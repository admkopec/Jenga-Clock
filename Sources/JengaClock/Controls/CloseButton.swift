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
            #if SKIP
            filledGrayX
            #else
            if #available(iOS 26.0, *) {
                Image(systemName: "xmark")
                    .foregroundStyle(Color.primary)
            } else {
                filledGrayX
            }
            #endif
        })
        .padding(.top, padding)
        .accessibilityLabel(Text("Close"))
    }
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
}

extension CloseButton {
    private var padding: CGFloat {
        if #available(iOS 26.0, *) { 0 } else { 6 }
    }
}

extension CloseButton {
    private var filledGrayX: some View {
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
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton(action: {
            //
        })
    }
}
