//
//  DrawPlayViewModel.swift
//  GreekKino
//
//  Created by Marko on 30.6.24..
//

import Foundation
import Combine

class DrawPlayViewModel: ObservableObject {
    
    @Published
    var draw: DrawModel
    
    var networkManager: NetworkManagerProtocol
    
    @Published var timeLeft: String = ""
    let daylightSaving = 3600
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var bag: [AnyCancellable] = []
    
    @Published
    var numbers: [NumbersRow] = []
    
    var odds: [Odd] = [
        Odd(odd: 3.5, number: 1),
        Odd(odd: 14, number: 2),
        Odd(odd: 65, number: 3),
        Odd(odd: 275, number: 4),
        Odd(odd: 1350, number: 5),
        Odd(odd: 6500, number: 6),
        Odd(odd: 25000, number: 7),
        Odd(odd: 30000, number: 8),
        Odd(odd: 40000, number: 9),
        Odd(odd: 60000, number: 10),
        Odd(odd: 80000, number: 11),
        Odd(odd: 100000, number: 12),
        Odd(odd: 120000, number: 13),
        Odd(odd: 140000, number: 14),
        Odd(odd: 150000, number: 15)
    ]
    
    var selectedQuoteIndex: Int {
        return odds.first { $0.isSelected }?.id ?? 1
    }
    
    init(draw: DrawModel, networkManager: NetworkManagerProtocol) {
        self.draw = draw
        self.networkManager = networkManager
        
        timer.receive(on: RunLoop.main)
            .sink { [weak self] input in
                self?.calculateTimeLeft(input: input)
                self?.shouldPlay(time: input)
            }
            .store(in: &bag)
        
        numbers = format(Array(1...80))
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
    
    func shouldPlay(time: Date) {
        if time.timeIntervalSince1970 <= drawDate.timeIntervalSince1970 {
            play()
        }
    }
    
    func play() {
        //TODO: Send request by calling upload function in network manager
    }
    
    
    func choose(number: NumberModel, row: Int) {
        let canSelect = canSelect()
        let modifiedSelection: [NumbersRow] = numbers.map { model in
            if model.id == row {
                let modifiedModel: [NumberModel] =  model.numberModel.map { numberModel in
                    if numberModel.id == number.id {
                        var isChoosen = numberModel.isChoosen
                        
                        if !canSelect && !isChoosen {
                            return numberModel
                        }
                        isChoosen.toggle()
                        return NumberModel(number: numberModel.number, isChoosen: isChoosen)
                    } else {
                        return numberModel
                    }
                }
                return NumbersRow(id: model.id, numberModel: modifiedModel)
            }
            else {
                return model
            }
        }
        numbers = modifiedSelection
        
        toggleOddsSelection()
    }
    
    var getNumberOfSelected: Int {
        numbers
            .flatMap { $0.numberModel  }
            .reduce(into: 0) { $0 = $1.isChoosen ? $0 + 1 : $0}
    }
    
    func canSelect(maximumSelected: Int = 15) -> Bool {
        return getNumberOfSelected < maximumSelected
    }
        
    func format(_ numbers: [Int], elementsInRow: Int = 10 ) -> [NumbersRow] {
        var outerArray: [NumbersRow] = []
        var tempNumberArray: [NumberModel] = []
        var row = 0
        
        for (index, number) in numbers.enumerated() {
            let formatedNumber = NumberModel(number: number)
            tempNumberArray.append(formatedNumber)
            if (index + 1) % elementsInRow == 0 {
                outerArray.append(NumbersRow(id: row, numberModel: tempNumberArray))
                tempNumberArray = []
                row += 1
            }
        }
        return outerArray
    }
    
    func toggleOddsSelection() {
        let numbersOfSelected = getNumberOfSelected
        if numbersOfSelected == 0 {
            odds = odds
                .reduce([]) { partialResult, next in
                partialResult + [Odd(odd: next.odd, number: next.number)]
            }
        } else {
            odds = odds
                .reduce([]) { partialResult, next in
                     return partialResult + [Odd(odd: next.odd, number: next.number, isSelected: next.number == numbersOfSelected)]
            }
        }
    }
}
