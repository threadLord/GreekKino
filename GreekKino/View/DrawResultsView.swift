//
//  DrawResultsView.swift
//  GreekKino
//
//  Created by Marko on 30.6.24..
//

import SwiftUI

struct DrawResultsView: View {
    
    @StateObject
    var drawResultsViewViewModel: DrawResultsViewViewModel = DrawResultsViewViewModel(networkManager: NetworkManager(), adapter: ModelAdapter())
    
    var body: some View {
        ScrollView(.vertical) {
            VStack (spacing: 0){
                ForEach(drawResultsViewViewModel.drawScheduleData) { drawModel in
                    
                    VStack {
                        HStack {
                            let drawTime = drawResultsViewViewModel.getDrawTime(time: drawModel.drawTime)
                            Text("Vreme: \(drawTime)")
                                .padding()
                            
                            Spacer()
                            
                            Text("Kolo: \(drawModel.drawID)")
                                .padding()
                        }
                        .border(.white)
                        
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 30))], spacing: 8) {
                            ForEach(drawModel.winningNumbers, id: \.self) { number in
                                
                                Text("\(number)")
                                    .foregroundStyle(.white)
                                    .padding(3)
                                    .background(
                                        Color.blue.clipShape(Circle())
                                            .frame(width: 32, height: 32)
                                    )              
                            }
                        }
                        .padding()
                        .border(.white.opacity(0.6))
                        .padding(.bottom, 24)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    .padding(.bottom, 16)
                }
            }
        }
        .onAppear {
            drawResultsViewViewModel.fetch()
        }
    }
}

//#Preview {
//    DrawResultsView()
//}
