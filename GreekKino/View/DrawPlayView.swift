//
//  PlayDraw.swift
//  GreekKino
//
//  Created by Marko on 30.6.24..
//

import SwiftUI

struct DrawPlayView: View {
    
    @EnvironmentObject
    private var coordinator: MainCoordinator
    
    @StateObject
    var drawPlayViewModel: DrawPlayViewModel
    
    init(draw: DrawModel) {
        self._drawPlayViewModel = StateObject(wrappedValue: DrawPlayViewModel(draw: draw))
        
    }
    
    var body: some View {
        
        GeometryReader(content: { geometry in
            
            VStack {
                Text(drawPlayViewModel.timeLeft)
                
                
                Spacer()
                
                
                ForEach(drawPlayViewModel.numbers, id: \.id) { numbersRow in
                    HStack {
                        ForEach(numbersRow.numberModel) { numberModel in
                            
                            Button(action: {
                                drawPlayViewModel.choose(number: numberModel, row: numbersRow.id)
                            }, label: {
                                Text("\(numberModel.number)")
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        numberModel.isChoosen ? Color.yellow : Color.black
//                                            .padding(.horizontal, 16)
//                                            .frame(width: (geometry.size.width - 40) / 10, height: 30)
                                    )
                            })
                            
                        }
                    }
                }
                            
                Spacer()
            }
        })
    }
}
