//
//  PlayState.swift
//  GreekKino
//
//  Created by Marko on 30.6.24..
//

import Foundation

enum PlayState: Identifiable {
    var id: PlayState {
        return self
    }
    
    case drawPlay
    case dradLive
    case drawResults
    
    var name: String {
        switch self {
        case .drawPlay:
            return "Talon"
        case .dradLive:
            return "Uzivo"
        case .drawResults:
            return "Rezultati"
        }
    }
}
