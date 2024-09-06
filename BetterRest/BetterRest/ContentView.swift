//
//  ContentView.swift
//  BetterRest
//
//  Created by Natalia Dal Pizzol on 02/09/24.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @ObservedObject var vm = BetterRestViewModel()
    let coffeeIntakeRange = [Int](0...20)
    @State var bedTime: String = ""

    var body: some View {
        NavigationStack {
                Form {
                    Section("When do you want to wake up?") {
                        DatePicker("Please enter a time", selection: $vm.wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .onChange(of: vm.wakeUp, {bedTime = vm.calculateBedtime()})
                    }
    
                    Section("Desired amount of sleep") {
                        Stepper("\(vm.sleepAmount.formatted()) hours", value: $vm.sleepAmount, in: 4...12, step: 0.25)
                            .onChange(of: vm.sleepAmount, {bedTime = vm.calculateBedtime()})

                    }
                    
                    Section("Daily coffee intake") {
                        Picker("^[\(vm.coffeeAmount) cup](inflect: true)", selection: $vm.coffeeAmount) {
                            ForEach(coffeeIntakeRange, id: \.self) {
                                Text("^[\($0) cup](inflect: true)")
                            }
                            .onChange(of: vm.coffeeAmount, {bedTime = vm.calculateBedtime()})


                        }
                    }
                    HStack(alignment: .center) {
                        Spacer()
                        RecomendedBedtimeComponent(time: $bedTime)
                        Spacer()
                    }
            }
            .navigationTitle("BetterRest")
        }
    }
}

#Preview {
    ContentView()
}
