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
            
            Divider()
                .foregroundStyle(.white)

            ZStack {
                DrawPlayView(draw: playHolderViewViewModel.drawModel)
                    .opacity(playHolderViewViewModel.state == .drawPlay ? 1.0 : 0.0)
               
                DrawLive()
                    .opacity(playHolderViewViewModel.state == .dradLive ? 1.0 : 0.0)
                
                DrawResultsView()
                    .opacity(playHolderViewViewModel.state == .drawResults ? 1.0 : 0.0)
            }
                       
            Spacer()
        }
    }
}

//#Preview {
//    PlayHolderView()
//}
