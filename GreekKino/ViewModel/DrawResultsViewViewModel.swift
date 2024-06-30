//
//  DrawResultsViewViewModel.swift
//  GreekKino
//
//  Created by Marko on 30.6.24..
//

import Foundation


class DrawResultsViewViewModel: DrawScheduleViewModel {
    
    func fetch() {
        getdraws(requestCreator: RequestCreator.last(gameID: 1100, limit: 20))
    }
    
    func getDrawTime(time: Int) -> String {
        var date: Date = Date(timeIntervalSince1970: TimeInterval(time/1000))
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        return "\(hour):\(minutes):\(seconds)"
    }
}
