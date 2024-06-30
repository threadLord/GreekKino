//
//  NumbersModel.swift
//  GreekKino
//
//  Created by Marko on 30.6.24..
//

import Foundation

struct NumberModel: Identifiable, Hashable {
    var id: Int {
        return number
    }
    
    var number: Int
    var isChoosen: Bool = false
}
