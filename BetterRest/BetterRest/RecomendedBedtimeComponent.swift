//
//  RecomendedBedtimeComponent.swift
//  BetterRest
//
//  Created by Natalia Dal Pizzol on 03/09/24.
//

import SwiftUI

struct RecomendedBedtimeComponent: View {
    @Binding var time: String
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Your recommended bedtime is...")
                .font(.title2)
                .multilineTextAlignment(.center)
            
            Text(time)
                .font(.largeTitle.bold())
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.teal)
        }
    }
}

