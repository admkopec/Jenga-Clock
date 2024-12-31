// This is free software: you can redistribute and/or modify it
// under the terms of the GNU General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

//
//  CloseButton.swift
//  Jenga-Clock
//
//  Created by Adam Kopeć on 23/04/2022.
//

import SwiftUI

struct CloseButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action, label: {
            Circle()
            #if !SKIP
                .fill(Color(.systemFill))
            #else
                .fill(Color.secondary.opacity(0.1))
            #endif
                .frame(width: 30, height: 30)
                .overlay(content: { 
                    Image(systemName: "xmark")
                        .font(Font.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(Color.secondary)

                })
        })
        .clipShape(Circle())
        .padding(.top, 6)
        .accessibilityLabel(Text("Close"))
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton(action: {
            //
        })
    }
}
