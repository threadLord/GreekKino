//
//  API.swift
//  GreekKino
//
//  Created by Marko on 28.6.24..
//

import Foundation


enum APIEnpoints {
    static var baseURL: URL {
        return try! URL(string: "https://" + Configuration.value(for: "BASE_URL"))!
    }
    
    static var baseURLString: String {
        do {
            let base: String = try Configuration.value(for: "BASE_URL")
            let https = "https://"
            return https + base
        } catch {
            return ""
        }
    }
    
    static var gameId: Int {
        do {
            let gameID: Int = try Configuration.value(for: "GAME_ID")
            return gameID
        } catch {
            return -1
        }
    }
}
