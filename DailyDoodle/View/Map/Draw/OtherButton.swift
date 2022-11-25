//
//  ButtonSave.swift
//  DailyDoodle
//
//  Created by Maria Letícia Dutra de Oliveira on 25/11/22.
//

import SwiftUI

struct OtherButton: View {
    @State var open = false

    var body: some View {
            Button(action: {
                self.open.toggle()
            },
            label: {
                Image(systemName: "plus")
                    .rotationEffect(.degrees(open ? 45 : 0))
                    .animation(.spring(response: 0.2, dampingFraction: 0.4, blendDuration: 0))
                    .foregroundColor(.white)
                    .font(.system(size: 25, weight: .bold))
                    .frame(width: 40, height: 40)
                    .background(Theme.pinkCTA)
                    .mask(Circle())

                SaveButton(open: $open, icon: "checkmark.circle.fill", offsetX: -70, offsetY: 50)
                SaveButton(open: $open, icon: "square.and.arrow.up.circle.fill", offsetX: -150, offsetY: 10)
            })
    }
}

struct OtherButton_Previews: PreviewProvider {
    static var previews: some View {
        OtherButton()
    }
}
