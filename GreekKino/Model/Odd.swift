//
//  Odd.swift
//  GreekKino
//
//  Created by Marko on 30.6.24..
//

import Foundation

struct Odd: Identifiable, Equatable {
    var odd: Float
    var number: Int
    var isSelected: Bool = false
    
    var formatedOdd: String {
        return odd < 10 ? String(format: "%.2f", odd) : String(format: "%.0f", odd)        
    }
    
    var id : Int {
        return number
    }
}
