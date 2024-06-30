//
//  DrawScheduleCell.swift
//  GreekKino
//
//  Created by Marko on 28.6.24..
//

import SwiftUI

struct DrawScheduleCell: View {
    var draw: DrawModel
    
    @State var timeLeft: String = ""
    let daylightSaving = 3600
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            Text(drawTime)
                .padding()
            
            Spacer()
            
            Text(timeLeft)
                .padding()
        }
        .onReceive(timer) { input in
            calculateTimeLeft(input: input)
        }
    }
    
    var drawDate: Date {
        return Date(timeIntervalSince1970: TimeInterval(draw.drawTime/1000))
    }
    
    var drawTime: String {
        let date = drawDate
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        return "\(hour):\(minutes):\(seconds)"
    }
    
    func calculateTimeLeft(input: Date) {
        let nowDate = input.timeIntervalSince1970
        var timeLeft = TimeInterval(draw.drawTime/1000) - nowDate
        timeLeft -= Double(daylightSaving)
        let initiatedDate = Date(timeIntervalSince1970: timeLeft)
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        
        let seconds = calendar.component(.second, from: initiatedDate)
        let minutes = calendar.component(.minute, from: initiatedDate)
        let hour = calendar.component(.hour, from: initiatedDate)
        var timeString: String {
            if hour == 0 {
                return "\(minutes):\(seconds)"
            } else {
                return "\(hour):\(minutes):\(seconds)"
            }
        }
        
        self.timeLeft = timeString
    }
}
