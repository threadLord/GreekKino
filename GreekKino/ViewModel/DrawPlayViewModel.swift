//
//  DrawPlayViewModel.swift
//  GreekKino
//
//  Created by Marko on 30.6.24..
//

import Foundation
import Combine


struct NumbersRow: Identifiable {
    var id: Int
    var numberModel: [NumberModel]
}

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
}


func binarySearch<T:Comparable>(_ inputArr:Array<T>, _ searchItem: T) -> Int? {
    var lowerIndex = 0
    var upperIndex = inputArr.count - 1

    while (true) {
        let currentIndex = (lowerIndex + upperIndex)/2
        if(inputArr[currentIndex] == searchItem) {
            return currentIndex
        } else if (lowerIndex > upperIndex) {
            return nil
        } else {
            if (inputArr[currentIndex] > searchItem) {
                upperIndex = currentIndex - 1
            } else {
                lowerIndex = currentIndex + 1
            }
        }
    }
}
