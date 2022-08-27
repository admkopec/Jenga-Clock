//
//  CloseButton.swift
//  Jenga Clock
//
//  Created by Adam Kopeć on 23/04/2022.
//

import SwiftUI

struct CloseButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action, label: {
            Circle()
                .fill(Color(.systemFill))
                .frame(width: 30, height: 30)
                .overlay(
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(.secondary)
                )
        })
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
