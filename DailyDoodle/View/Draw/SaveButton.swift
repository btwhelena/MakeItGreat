//
//  SaveButton.swift
//  DailyDoodle
//
//  Created by Maria Letícia Dutra de Oliveira on 25/11/22.
//

import SwiftUI

struct SaveButton: View {
    @Binding var open: Bool

    var action: () -> Void
    var icon = "checkmark"
    var offsetX = 0
    var offsetY = 0
    var delay = 0.0

    var body: some View {

        Button(action: {

            action()

        }, label: {
            Image(systemName: icon)
                .foregroundColor(Theme.pinkCTA)
                .font(.system(size: 40, weight: .bold))
        })
        .padding()
        .mask(Circle())
        .offset(x: open ? CGFloat(offsetX) : 0, y: open ? CGFloat(offsetY) : 0)
        .scaleEffect(open ? 1 : 0)
        .animation(Animation.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0).delay(Double(delay)))
    }
}
