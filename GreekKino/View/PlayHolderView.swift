//
//  PlayHolderView.swift
//  GreekKino
//
//  Created by Marko on 30.6.24..
//

import SwiftUI

enum PlayState {
    case drawPlay
    case dradLive
    case results
}


struct PlayHolderView: View {
    
    @State
    var state: PlayState = .drawPlay
    
    init(draw: DrawModel) {
        
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//#Preview {
//    PlayHolderView()
//}
