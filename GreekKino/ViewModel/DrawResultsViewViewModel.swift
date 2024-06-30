//
//  DrawResultsViewViewModel.swift
//  GreekKino
//
//  Created by Marko on 30.6.24..
//

import Foundation


class DrawResultsViewViewModel: DrawScheduleViewModel {
//    var error: NetworkError?
//    let networkManager: NetworkManagerProtocol
//    let adapter: ModelAdapterProtocol
//    
//    init(networkManager: NetworkManagerProtocol, adapter: ModelAdapterProtocol) {
//        self.networkManager = networkManager
//        self.adapter = adapter
//    }
//    
//    func fetch() {
//        getdraws()
//    }
//    
//    
//    func getdraws() {
//        guard let urlRequest = RequestCreator.last(gameID: 1100, limit: 20).request else {
////            error = .requestFailed
//            return
//        }
//        
//        Task {
//            do {
//                let networkDraws: DrawModelArray = try await networkManager.download(request: urlRequest, type: [DrawModelNetwork].self)
//                let adaptedDraws = networkDraws.map(adapter.draw(_:))
//                let sortedData = sort(draws: adaptedDraws)
//                await MainActor.run {
////                    drawScheduleData = sortedData
//                }
//            } catch let networkError {
//                self.error = networkError as? NetworkError
//            }
//        }
//    }
//    
//
//    
//    func sort(draws: [DrawModel]) -> [DrawModel] {
//        return draws.sorted { $0.drawTime < $1.drawTime }
//    }
    
    func fetch() {
        getdraws(requestCreator: RequestCreator.last(gameID: 1100, limit: 20))
    }
}
