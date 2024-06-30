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
        self._drawPlayViewModel = StateObject(wrappedValue: DrawPlayViewModel(draw: draw, networkManager: NetworkManager()))
        
    }
    
    var body: some View {
        
        GeometryReader(content: { geometry in
            
            VStack {
                
                HStack {
                    Text("Vreme: \(drawPlayViewModel.drawTime)")
                    Text("| Kolo: \(drawPlayViewModel.draw.drawID)")
                                        Spacer()
                    Text(drawPlayViewModel.timeLeft)
                    
                    
                }
                .padding(8)
              
                
                HStack {
                    VStack {
                        Text("B.K.")
                        Text("Kvota")
                            .padding(8)
                    }
                    
                    ScrollViewReader(content: { proxy in
                        ScrollView(.horizontal) {
                            HStack {
                                                               
                                ForEach(drawPlayViewModel.odds) { odd in
                                    VStack {
                                        Text("\(odd.number)")
                                        Text("\(odd.formatedOdd)")
                                            .padding(8)
                                            .background(
                                                odd.isSelected ? Color.yellow.clipShape(Capsule()) : Color.black.clipShape(Capsule())
                                            )
                                    }
                                    .id(odd.id)
                                    .onChange(of: drawPlayViewModel.selectedQuoteIndex) {
                                        proxy.scrollTo(drawPlayViewModel.selectedQuoteIndex)
                                    }
                                }
                            }
                        }
                    })
            }
                Spacer()
                
                
                ForEach(drawPlayViewModel.numbers, id: \.id) { numbersRow in
                    HStack {
                        ForEach(numbersRow.numberModel) { numberModel in
                            
                            Button(action: {
                                drawPlayViewModel.choose(number: numberModel, row: numbersRow.id)
                            }, label: {
                                Text("\(numberModel.number)")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(
                                        numberModel.isChoosen ? Color.yellow.clipShape(Circle()) : Color.black.clipShape(Circle())
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
