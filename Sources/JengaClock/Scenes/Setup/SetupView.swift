// This is free software: you can redistribute and/or modify it
// under the terms of the GNU General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

//
//  SetupView.swift
//  Jenga-Clock
//
//  Created by Adam Kopeć on 22/04/2022.
//

import SwiftUI

struct SetupView: View {
    @AppStorage("chooseStartingPlayer") private var chooseStartingPlayer = false
    
    @StateObject private var viewModel = SetupViewModel()
    
    @State var showRules = false
    @State var showSettings = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("Choose starting time")
                .font(.title)
                .fontWeight(.semibold)
                .padding()
            #if SKIP
            MultiPickerView(minutesRange: viewModel.minutesRange,
                            secondsRange: viewModel.secondsRange,
                            selectedTimeMin: $viewModel.selectedTimeMin,
                            selectedTimeSec: $viewModel.selectedTimeSec)
                .scaleEffect(CGSize(width: 1.1, height: 1.1))
                .padding()
                .padding(.top, 40)
            #else
            MultiPickerView(data: viewModel.minutesColumn,
                            viewModel.secondsColumn,
                            selection: $viewModel.selectedTimeMin,
                            $viewModel.selectedTimeSec)
                .padding()
            #endif
            Spacer()
            NavigationLink {
                ClockView(startingTime: viewModel.startingTime,
                          shouldPlayerStart: chooseStartingPlayer)
            } label: {
                Label("Start", systemImage: "play.fill")
                    .padding(.horizontal, 85)
                    .padding(.vertical, 5)
            }
            .disabled(viewModel.startButtonDisabled)
            .buttonStyle(.borderedProminent)
            .cornerRadius(12, antialiased: true)
            Spacer()
            HStack {
                Button {
                    showRules = true
                } label: {
                    Label("Rules", systemImage: "book")
                }
                .buttonStyle(.bordered)
                .tint(Colors.accentColor)
                .font(.subheadline)
                .padding(.vertical)
                .padding(.horizontal, 5)
                Button {
                    showSettings = true
                } label: {
                    Label("Settings", systemImage: "gearshape")
                }
                .buttonStyle(.bordered)
                .tint(Colors.accentColor)
                .font(.subheadline)
                .padding(.vertical)
                .padding(.horizontal, 5)
            }
        }
        .onAppear {
            Analytics.showScreen("SetupView")
        }
        .sheet(isPresented: $showRules) {
            RulesView(showRules: $showRules)
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(shouldShowSelf: $showSettings)
        }
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SetupView()
        }
    }
}
