//
//  QuickSetupView.swift
//  Jenga Clock AppClip
//
//  Created by Adam Kopeć on 23/04/2022.
//

import SwiftUI

struct QuickSetupView: View {
    @State var selectedTime = [4, 0]
    
    let minutesColumn: [String] = {
        var res = [String]()
        for i in 1...9 {
            res.append("\(i) min")
        }
        return res
    }()
    let secondsColumn: [String] = {
        var res = [String]()
        for i in [0, 15, 30, 45] {
            res.append("\(i) sec")
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
            MultiPickerView(data: [minutesColumn, secondsColumn], selections: $selectedTime)
                .padding()
            Spacer()
            NavigationLink {
                ContentView(startingTime: (selectedTime[0]+1)*60 + selectedTime[1]*15, shouldAPlayerStart: true)
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
