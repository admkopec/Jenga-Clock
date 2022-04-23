//
//  QuickRulesView.swift
//  Jenga Clock AppClip
//
//  Created by Adam Kopeć on 23/04/2022.
//

import SwiftUI

struct QuickRulesView: View {
    @Binding var showQuickRules: Bool
    var body: some View {
        VStack {
            GroupBox {
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
            .padding(.top, 30)
            .padding([.horizontal, .bottom])
            Spacer()
            Button {
                showQuickRules = false
            } label: {
                Label("Let's play!", systemImage: "play.fill")
                    .padding(.horizontal, 80)
                    .padding(.vertical, 5)
            }
            .buttonStyle(.borderedProminent)
            .cornerRadius(12, antialiased: true)
            .padding(.vertical)
            Spacer()
        }
    }
}

struct QuickRulesView_Previews: PreviewProvider {
    static var previews: some View {
        QuickRulesView(showQuickRules: .constant(true))
    }
}
