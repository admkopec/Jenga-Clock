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
            ZStack {
                Circle()
                    .fill(.thinMaterial)
                    .frame(width: 30, height: 30)
                
                Image(systemName: "xmark")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundColor(.secondary)
            }
            .padding(8)
            .contentShape(Circle())
        })
        .buttonStyle(PlainButtonStyle())
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
