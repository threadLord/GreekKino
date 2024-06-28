//
//  RequestCreator.swift
//  GreekKino
//
//  Created by Marko on 28.6.24..
//

import Foundation

enum RequestCreator {
    case game(id: Int = APIEnpoints.gameId)
    case draw(gameId: Int, drawId: Int)
    
    var request: URLRequest? {
        switch self {
        case .game(let id):
            guard let url = URL(string: APIEnpoints.baseURLString + String(id)) else {
                return nil
            }
            return URLRequest(url: url)
            
        case .draw(let gameId, let drawId):
            let urlString = APIEnpoints.baseURLString + "/" + String(gameId) + "/" + String(drawId)
            guard let url = URL(string: urlString) else {
                return nil
            }
            return URLRequest(url: url)
        }
    }
}
