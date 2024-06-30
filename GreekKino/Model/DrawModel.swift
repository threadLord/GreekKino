//
//  DrawModel.swift
//  GreekKino
//
//  Created by Marko on 28.6.24..
//

import Foundation


struct DrawModel: Identifiable {
    var id: Int {
        return drawTime
    }
    
    let gameID, drawID, drawTime: Int
    let winningNumbers: [Int]
//    let status: Status
//    let drawBreak, visualDraw: Int
}
