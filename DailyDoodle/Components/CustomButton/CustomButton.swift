//
//  CustomButton.swift
//  DailyDoodle
//
//  Created by Lais Godinho on 29/11/22.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var backgroundColor: Color = Color.accentColor
    var foregroundColor: Color = Color.white
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom(FontsManager.Eri_Serif.regular, size: 17))
                .foregroundColor(foregroundColor)
                .padding(15)
        }
        .background(backgroundColor)
        .cornerRadius(30)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(title: "Start Challenge", action: {})
            .previewLayout(.sizeThatFits)
    }
}
