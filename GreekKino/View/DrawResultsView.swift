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
                                    Text("Vreme: \(drawModel.drawTime)")
                                    
                                    Text("| Kolo: \(drawModel.drawID)")
                                    
                                }
                                
                                ForEach(drawModel.winningNumbers, id: \.self) { number in
                                    
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
