//
//  DrawScheduleViewModel.swift
//  GreekKino
//
//  Created by Marko on 28.6.24..
//

import Foundation


class DrawScheduleViewModel: ObservableObject {
    
    var error: NetworkError?
    
    @Published
    var drawScheduleData: [DrawModel] = []
    
    let networkManager: NetworkManagerProtocol
    let adapter: ModelAdapterProtocol
    
    init(networkManager: NetworkManagerProtocol, adapter: ModelAdapterProtocol) {
        self.networkManager = networkManager
        self.adapter = adapter
    }
    
    func getdraws() {
        guard let urlRequest = RequestCreator.game(id: 1100).request else {
            error = .requestFailed
            return
        }
        
        Task {
            do {
                let networkDraws: DrawModelArray = try await networkManager.download(request: urlRequest, type: [DrawModelNetwork].self)
                let adaptedDraws = networkDraws.map(adapter.draw(_:))
                let sortedData = sort(draws: adaptedDraws)
                await MainActor.run {
                    drawScheduleData = sortedData
                }
            } catch let networkError {
                self.error = networkError as? NetworkError
            }
        }
    }
    
    func sort(draws: [DrawModel]) -> [DrawModel] {
        return draws.sorted { $0.drawTime < $1.drawTime }
    }
}
