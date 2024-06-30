//
//  PlayHolderViewViewModel.swift
//  GreekKino
//
//  Created by Marko on 30.6.24..
//

import Foundation

class PlayHolderViewViewModel: ObservableObject {
    @Published
    var state: PlayState = .drawPlay
    
    var allState: [PlayState] = [.drawPlay, .dradLive, .drawResults]
    
    var drawModel: DrawModel
    
    init(draw: DrawModel) {
        self.drawModel = draw
    }
    
    func select(state: PlayState) {
        self.state = state
    }
}
