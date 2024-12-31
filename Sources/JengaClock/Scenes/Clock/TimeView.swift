// This is free software: you can redistribute and/or modify it
// under the terms of the GNU General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

//
//  TimeView.swift
//  Jenga-Clock
//
//  Created by Adam Kopeć on 25/12/2024.
//

import SwiftUI

struct TimeView: View {
    let invertTextOrientation: Bool
    
    let timeLeft: String
    let isActive: Bool
    let activeBackground: Color
    
    let tapAction: () -> Void
    
    var body: some View {
        if isActive {
            VStack {
                Spacer()
                Text(timeLeft)
                #if !SKIP
                    .contentTransition(.numericText(countsDown: true))
                    .font(.largeTitle.monospacedDigit())
                #else
                    .font(.largeTitle)
                #endif
                    .fontWeight(.bold)
                    .padding()
                    .rotationEffect((invertTextOrientation ? .radians(.pi) : .radians(0)))
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                Spacer()
            }
            .background(activeBackground)
            .frame(maxWidth: .infinity)
            .animation(.default, value: timeLeft)
        } else {
            VStack {
                Spacer()
                Text(timeLeft)
                #if !SKIP
                    .font(.title.monospacedDigit())
                #else
                    .font(.title)
                #endif
                    .fontWeight(.semibold)
                    .padding()
                    .rotationEffect((invertTextOrientation ? .radians(.pi) : .radians(0)))
                    .frame(maxWidth: .infinity)
                Spacer()
            }
            .background()
            .onTapGesture {
                tapAction()
            }
        }
    }
    
    init(invertTextOrientation: Bool = false,
         timeLeft: String, isActive: Bool, activeBackground: Color,
         tapAction: @escaping () -> Void) {
        self.invertTextOrientation = invertTextOrientation
        self.timeLeft = timeLeft
        self.isActive = isActive
        self.activeBackground = activeBackground
        self.tapAction = tapAction
    }
}
