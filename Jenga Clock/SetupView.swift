//
//  SetupView.swift
//  Jenga Clock
//
//  Created by Adam Kopeć on 22/04/2022.
//

import SwiftUI

struct SetupView: View {
    @AppStorage("chooseStartingPlayer") private var chooseStartingPlayer = false
    @State var selectedTime = [5, 0]
    
    let minutesColumn: [String] = {
        var res = [String]()
        for i in 0...30 {
            res.append("\(i) min")
        }
        return res
    }()
    let secondsColumn: [String] = {
        var res = [String]()
        for i in 0...59 {
            res.append("\(i) sec")
        }
        return res
    }()
    
    @State var showRules = false
    @State var showSettings = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("Choose starting time")
                .font(.title)
                .fontWeight(.semibold)
                .padding()
            MultiPickerView(data: [minutesColumn, secondsColumn], selections: $selectedTime)
                .padding()
            Spacer()
            NavigationLink {
                ContentView(startingTime: selectedTime[0]*60 + selectedTime[1], shouldAPlayerStart: chooseStartingPlayer)
            } label: {
                Label("Start", systemImage: "play.fill")
                    .padding(.horizontal, 85)
                    .padding(.vertical, 5)
            }
            .disabled(selectedTime[0] == 0 && selectedTime[1] == 0)
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
                .tint(.accentColor)
                .font(.subheadline)
                .padding(.vertical)
                .padding(.horizontal, 5)
                Button {
                    showSettings = true
                } label: {
                    Label("Settings", systemImage: "gearshape")
                }
                .buttonStyle(.bordered)
                .tint(.accentColor)
                .font(.subheadline)
                .padding(.vertical)
                .padding(.horizontal, 5)
            }
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
