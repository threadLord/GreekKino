//
//  Screen.swift
//  GreekKino
//
//  Created by Marko on 1.7.24..
//

import Foundation

enum Screen: Identifiable, Hashable, Equatable {
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    var id: Screen {
        return self
    }
    
    case main
    case play(model: DrawModel)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .main:
            hasher.combine("main")
        case .play(let model):
            hasher.combine("play")
            hasher.combine(model.id)
        }
    }
}
