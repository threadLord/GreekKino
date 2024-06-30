//
//  CoordinatorView.swift
//  GreekKino
//
//  Created by Marko on 30.6.24..
//

import SwiftUI

struct MainCoordinatorView: View {
    @StateObject
    private var coordinator = MainCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.buld(screen: .main)
                .navigationDestination(for: Screen.self) { screen in
                    coordinator.buld(screen: screen)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.buld(sheet: sheet)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) { fullscreenCover in
                    coordinator.buld(fullscreen: fullscreenCover)
                }
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    MainCoordinatorView()
}
