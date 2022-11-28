//
//  CloseButton.swift
//  DailyDoodle
//
//  Created by Maria Letícia Dutra de Oliveira on 26/11/22.
//

import SwiftUI

struct CloseButton: View {
    var body: some View {
        Button(action: {

        },
               label: {
            Image(systemName: "xmark.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(Theme.pinkCTA)

        })
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton()
    }
}
