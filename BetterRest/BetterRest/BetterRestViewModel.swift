//
//  BetterRestViewModel.swift
//  BetterRest
//
//  Created by Natalia Dal Pizzol on 03/09/24.
//

import SwiftUI
import CoreML

class BetterRestViewModel: ObservableObject {
    @Published var wakeUp = defaultWakeTime
    @Published var sleepAmount = 8.0
    @Published var coffeeAmount = 1
    @Published var showingAlert = false

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    
    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let bedtimeRecommendation = sleepTime.formatted(date: .omitted, time: .shortened)
            return  bedtimeRecommendation

        } catch {
            return " "
        }
    }
}

