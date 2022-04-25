//
//  QuickSetupView.swift
//  Jenga Clock AppClip
//
//  Created by Adam Kopeć on 23/04/2022.
//

import SwiftUI

struct QuickSetupView: View {
    @State var selectedTimeMin = 2
    @State var selectedTimeSec = 0
    
    private static let minutesValues = [2, 4, 5, 6, 8, 10]
    private let minutesColumn: [String] = {
        var res = [String]()
        for i in minutesValues {
            res.append("\(i) \(NSLocalizedString("min", comment: ""))")
        }
        return res
    }()
    private let secondsColumn: [String] = {
        var res = [String]()
        for i in [0, 15, 30, 45] {
            res.append("\(i) \(NSLocalizedString("sec", comment: ""))")
        }
        return res
    }()

    var body: some View {
        VStack {
            Spacer()
            Text("Choose starting time")
                .font(.title)
                .fontWeight(.semibold)
                .padding()
            MultiPickerView(data: minutesColumn, secondsColumn, selection: $selectedTimeMin, $selectedTimeSec)
                .padding()
            Spacer()
            NavigationLink {
                ContentView(startingTime: (QuickSetupView.minutesValues[selectedTimeMin])*60 + selectedTimeSec*15, shouldAPlayerStart: true)
            } label: {
                Label("Start", systemImage: "play.fill")
                    .padding(.horizontal, 80)
                    .padding(.vertical, 5)
            }
            .buttonStyle(.borderedProminent)
            .cornerRadius(12, antialiased: true)
            Spacer()
        }
    }
}

struct QuickSetupView_Previews: PreviewProvider {
    static var previews: some View {
        QuickSetupView()
    }
}
