//
//  RulesView.swift
//  Jenga Clock
//
//  Created by Adam Kopeć on 23/04/2022.
//

import SwiftUI

struct RulesView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                CloseButton{
                    presentationMode.wrappedValue.dismiss()
                }
                .padding(.top, 10)
                .padding(.horizontal, 5)
            }
            GroupBox {
                ScrollView {
                    HStack {
                        Text("Rules of Jenga")
                            .font(.title)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.bottom)
                    Text("The rules of *Chess Clock Jenga* 🧱 are pretty straightforward. The players try to play Jenga as fast as possible without topping it over. The player who tops over the Jenga or whose time runs out _looses_!\n\nThe players should remove and place blocks using just **one** hand. The same hand which placed the block should also be used to set the clock 😉 The blocks from **2 top most levels** shouldn't be removed. That's pretty much all.\n\n**Enjoy the play!**")

                }
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulesView()
    }
}
