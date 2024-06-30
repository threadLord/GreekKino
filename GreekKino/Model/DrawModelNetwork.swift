//
//  DrawModel.swift
//  GreekKino
//
//  Created by Marko on 28.6.24..
//

import Foundation

struct DrawModelNetwork: Codable {
    let gameID, drawID, drawTime: Int
    let status: Status
    let drawBreak, visualDraw: Int
    let winningNumbers: WinningNumbers?

    enum CodingKeys: String, CodingKey {
        case gameID = "gameId"
        case drawID = "drawId"
        case drawTime
        case drawBreak, visualDraw
        case status
        case winningNumbers
    }
}

enum Status: String, Codable {
    case active = "active"
    case results = "results"
    case future = "future"
}


// MARK: - WinningNumbers
struct WinningNumbers: Codable {
    let list, bonus: [Int]
}

typealias DrawModelArray = [DrawModelNetwork]
