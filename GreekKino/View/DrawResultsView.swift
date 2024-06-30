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
                                    
                                    Text("| Kolo: \(drawModel.drawID)")
                                    
                                    Spacer()
                                    
                                }
                                
                                ForEach(drawModel.winningNumbers, id: \.self) { number in
                                    HStack {
                                        Text("\(number)")
                                            .padding(EdgeInsets())
                                            .background(
                                                Color.yellow
                                            )
                                    }
                                }
                        }
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
