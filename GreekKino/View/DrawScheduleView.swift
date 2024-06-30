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
                .foregroundStyle(.white)
            
            Spacer()
            
            Text("Preostalo vreme")
                .foregroundStyle(.white)
        }
        .padding()
        .padding(.horizontal, 8)
        
        List {
            ForEach(drawScheduleViewModel.drawScheduleData) { drawModel in
                DrawScheduleCell(draw: drawModel) {
                    coordinator.push(.play(model: drawModel))
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
