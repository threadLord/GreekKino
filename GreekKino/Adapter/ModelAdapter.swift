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
        
        return DrawModel(gameID: networkModel.gameID, drawID: networkModel.drawID, drawTime: networkModel.drawTime)
//                         status: networkModel.status, drawBreak: networkModel.drawBreak, visualDraw: networkModel.visualDraw)
    }
}
