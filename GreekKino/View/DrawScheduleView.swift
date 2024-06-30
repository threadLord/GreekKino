//
//  DrawSchedule.swift
//  GreekKino
//
//  Created by Marko on 28.6.24..
//

import SwiftUI

struct DrawScheduleView: View {
    
    @EnvironmentObject
    private var coordinator: MainCoordinator
    
    @StateObject
    var drawScheduleViewModel: DrawScheduleViewModel = DrawScheduleViewModel(networkManager: NetworkManager(), adapter: ModelAdapter())
    
    var body: some View {
        
        HStack {
            Text("Vreme izvlačenja")
            
            Spacer()
            
            Text("Preostalo vreme")
        }
        .padding()
        
        ScrollView(.vertical) {
            VStack (spacing: 0){
                ForEach(drawScheduleViewModel.drawScheduleData) { drawModel in
                    DrawScheduleCell(draw: drawModel)
                        .onTapGesture {
                            coordinator.push(.play(model: drawModel))
                        }
                }
            }
        }
        .onAppear {
            drawScheduleViewModel.getdraws()
        }
    }
}

#Preview {
    DrawScheduleView()
}
