//
//  ModelAdapter.swift
//  GreekKino
//
//  Created by Marko on 28.6.24..
//

import Foundation

protocol ModelAdapterProtocol {
    func draw(_ networkModel: DrawModelNetwork) -> DrawModel
}


struct ModelAdapter: ModelAdapterProtocol {
    func draw(_ networkModel: DrawModelNetwork) -> DrawModel {
        var winningNumbers = networkModel.winningNumbers?.list ?? []
        let removedDuplicateNumbers = Set(winningNumbers.map { $0 })
        winningNumbers = Array(removedDuplicateNumbers)
        
        return DrawModel(gameID: networkModel.gameID, drawID: networkModel.drawID, drawTime: networkModel.drawTime, winningNumbers: winningNumbers)
//                         status: networkModel.status, drawBreak: networkModel.drawBreak, visualDraw: networkModel.visualDraw)
    }
}
