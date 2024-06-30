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
    case last(gameID: Int, limit: Int)
    
    var request: URLRequest? {
        switch self {
        case .game(let id):
            let urlString: String = APIEnpoints.baseURLString + String(id) + "/upcoming/20"
            return createRequest(url: urlString)
        case .draw(let gameId, let drawId):
            let urlString = APIEnpoints.baseURLString + "/" + String(gameId) + "/" + String(drawId)
            return createRequest(url: urlString)
        case .last(let id, let limit):
            let urlString: String = APIEnpoints.baseURLString + String(id) + "/last/" + String(limit)
            return createRequest(url: urlString)
        }
    }
    
    func createRequest(url: String) -> URLRequest? {
        guard let url = URL(string: url) else {
            return nil
        }
        return URLRequest(url: url)
    }
}
