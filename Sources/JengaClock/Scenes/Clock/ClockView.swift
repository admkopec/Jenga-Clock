// This is free software: you can redistribute and/or modify it
// under the terms of the GNU General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

//
//  ClockView.swift
//  Jenga-Clock
//
//  Created by Adam Kopeć on 22/04/2022.
//

import SwiftUI
import Combine
#if !SKIP
import CoreHaptics
import AudioToolbox
#endif

public struct ClockView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @AppStorage("invertTextOrientation")
    private var invertTextOrientation = true
    
    @StateObject
    var viewModel: ClockViewModel
        
    public var body: some View {
        GeometryReader { geometry in
            VStack() {
                TimeView(invertTextOrientation: invertTextOrientation,
                         timeLeft: viewModel.playerATimeLeft,
                         isActive: viewModel.playerAsTurn,
                         activeBackground: viewModel.playerAsBackground) {
                    if viewModel.playerAsTurn == viewModel.playerZsTurn {
                        viewModel.playerAsTurn = true
                    }
                }
                
                TimeView(timeLeft: viewModel.playerZTimeLeft,
                         isActive: viewModel.playerZsTurn,
                         activeBackground: viewModel.playerZsBackground) {
                    if viewModel.playerAsTurn == viewModel.playerZsTurn {
                        viewModel.playerZsTurn = true
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
//            .simultaneousGesture(TapGesture().onEnded({
            .gesture(TapGesture().onEnded({
                viewModel.switchTurns {
                    dismiss()
                }
            }))
        }
        .animation(.default, value: viewModel.playerAsTurn)
        .animation(.default, value: viewModel.playerZsTurn)
        .onAppear {
            viewModel.onAppearActions()
        }
        .onDisappear {
            viewModel.onDisappearActions()
        }
        .ignoresSafeArea()
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(Visibility.hidden, for: .navigationBar)
    }
    
    public init(startingTime: Int, shouldPlayerStart: Bool = false) {
        _viewModel = StateObject(wrappedValue: ClockViewModel(startingTime: startingTime, shouldPlayerStart: shouldPlayerStart))
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView(startingTime: 0)
    }
}
