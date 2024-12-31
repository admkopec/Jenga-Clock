// This is free software: you can redistribute and/or modify it
// under the terms of the GNU General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

//
//  RulesView.swift
//  Jenga-Clock
//
//  Created by Adam Kopeć on 23/04/2022.
//

import SwiftUI

struct RulesView: View {
    @Binding var showRules: Bool
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    HStack {
                        Text("Rules of Jenga")
                            .font(.title)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.bottom)
                    ScrollView {
                        Text("The rules of *Chess Clock Jenga* 🧱 are pretty straightforward. The players try to play Jenga as fast as possible without topping it over. The player who tops over the Jenga or whose time runs out _looses_!\n\nThe players should remove and place blocks using just **one** hand. The same hand which placed the block should also be used to set the clock 😉 The blocks from **2 top most levels** shouldn't be removed. That's pretty much all.\n\n**Enjoy the play!**")
                    }
                }
                .padding()
                #if !SKIP
                .background(Color(UIColor.secondarySystemBackground))
                #else
                .background(Color.secondary.opacity(0.1))
                #endif
                .cornerRadius(12)
                .padding(.horizontal)
                .frame(maxHeight: .infinity)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    CloseButton {
                        showRules = false
                    }
                }
            }
        }
    }
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            
        }.sheet(isPresented: .constant(true)) {
            RulesView(showRules: .constant(true))
        }
    }
}
