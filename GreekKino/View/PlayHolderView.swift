//
//  PlayHolderView.swift
//  GreekKino
//
//  Created by Marko on 30.6.24..
//

import SwiftUI


struct PlayHolderView: View {
    
    @EnvironmentObject
    private var coordinator: MainCoordinator
    
    @StateObject
    var playHolderViewViewModel: PlayHolderViewViewModel
    
    
    init(draw: DrawModel) {
        self._playHolderViewViewModel = StateObject(wrappedValue: PlayHolderViewViewModel(draw: draw))
    }

    var body: some View {
        VStack {
            HStack{
                ForEach(playHolderViewViewModel.allState) { state in
                    Button(action: {
                        print("Talon")
                        playHolderViewViewModel.select(state: state)
                    }, label: {
                        Text(state.name)
                            .foregroundStyle(.white)
                            .padding()
                            .background {
                                playHolderViewViewModel.state == state ? Color.red.clipShape(Capsule()) : Color.black.clipShape(Capsule())
                            }
                    })
                }
            }
            
            DrawPlayView(draw: playHolderViewViewModel.drawModel)
                .opacity(playHolderViewViewModel.state == .drawPlay ? 1.0 : 0.0)
        }
    }
}

//#Preview {
//    PlayHolderView()
//}
