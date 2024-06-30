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
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Text("Kolo: \(drawPlayViewModel.draw.drawID)")
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Text(drawPlayViewModel.timeLeft)
                        .multilineTextAlignment(.trailing)
                }
                .padding(.horizontal ,16)
                .padding(.vertical, 8)
                
                HStack {
                    VStack {
                        Text("B.K.")
                            .multilineTextAlignment(.leading)
                        
                        Text("Kvota")
                            .multilineTextAlignment(.leading)
                            .padding(.vertical, 8)
                    }
                    
                    Divider()
                        .foregroundStyle(.white)
                    
                    ScrollViewReader(content: { proxy in
                        ScrollView(.horizontal) {
                            HStack {
                                
                                ForEach(drawPlayViewModel.odds) { odd in
                                    VStack {
                                        Text("\(odd.number)")
                                        
                                        Text("\(odd.formatedOdd)")
                                            .foregroundStyle(.white)
                                            .padding(8)
                                            .background(
                                                
                                                odd.isSelected ? Color.purple.clipShape(Capsule()) : Color.black.clipShape(Capsule())
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
                .padding(.horizontal)
                
                Divider()
                    .foregroundStyle(.white)
                
                Spacer()
                
                
                ForEach(drawPlayViewModel.numbers, id: \.id) { numbersRow in
                    HStack {
                        ForEach(numbersRow.numberModel) { numberModel in
                            
                            Button(action: {
                                drawPlayViewModel.choose(number: numberModel, row: numbersRow.id)
                            }, label: {
                                Text("\(numberModel.number)")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .foregroundStyle(.white)
                                    .background(
                                        numberModel.isChoosen ? Color.blue.clipShape(Circle()) : Color.black.clipShape(Circle())
                                    )
                            })
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
        })
    }
}
