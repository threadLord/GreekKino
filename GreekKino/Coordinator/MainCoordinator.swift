//
//  Coordinator.swift
//  GreekKino
//
//  Created by Marko on 30.6.24..
//

import Foundation
import SwiftUI

enum Sheet: Identifiable {
    var id: Sheet {
        return self
    }
    
    case none
}

enum FullScreenCover: Identifiable {
    var id: FullScreenCover {
        return self
    }
    
    case none
}

enum Screen: Identifiable, Hashable, Equatable {
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    
    var id: Screen {
        return self
    }
    
    case main
    case play(model: DrawModel)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .main:
            hasher.combine("main")
        case .play(let model):
            hasher.combine("play")
            hasher.combine(model.id) // Use any property from VideoModel
        }
    }
    
}

class MainCoordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func present(sheet: Sheet) {
        self.sheet = sheet
    }
    
    func present(fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    
    @ViewBuilder
    func buld(screen: Screen) -> some View {
        switch screen {
        case .main:
            DrawScheduleView()
        case .play(let model):
            DrawPlayView(draw: model)
        }
    }
    
    @ViewBuilder
    func buld(sheet: Sheet) -> some View {
        switch sheet {
        case .none:
            EmptyView()
        }
    }
    
    @ViewBuilder
    func buld(fullscreen: FullScreenCover) -> some View {
        switch fullscreen {
        case .none:
            EmptyView()
        }
    }
}

