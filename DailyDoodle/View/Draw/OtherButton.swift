//
//  ButtonSave.swift
//  DailyDoodle
//
//  Created by Maria Letícia Dutra de Oliveira on 25/11/22.
//

import SwiftUI

struct OtherButton: View {
    @State var open = false
    var action: () -> Void

    var body: some View {
        ZStack{
            Button(action: {
                    self.open.toggle()
                },
                label: {
                    Image(systemName: "plus")
                        .rotationEffect(.degrees(open ? 45 : 0))
                        .font(.system(size: 20, weight: .bold))
                        .animation(.spring(response: 0.2, dampingFraction: 0.4, blendDuration: 0))
                        .foregroundColor(.white)
            })
        }
        .padding(12)
        .background(Theme.pinkCTA)
        .mask(Circle())
        .zIndex(10)

        SaveButton(open: $open, action: action, icon: "checkmark.circle.fill", offsetX: -75, offsetY: 65)
        ShareButton(open: $open, icon: "square.and.arrow.up.circle.fill", offsetX: -164, offsetY: 120, delay: 0.2)


    }
}

struct OtherButton_Previews: PreviewProvider {
    static var previews: some View {
        OtherButton(action: {})
    }
}
