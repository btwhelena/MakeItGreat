//
//  StreakCardView.swift
//  DailyDoodle
//
//  Created by Helena Oliveira on 29/11/22.
//
import Foundation
import SwiftUI

struct StreakCardView: View {

    let title: String
    let streak: Int

    var body: some View {
        ZStack{
            VStack {
                Text(title)
                    .font(.custom(FontsManager.Eri_Serif.regular, size: 20))
                    .foregroundColor(Color.white)
                    .padding(.bottom, 5)

                Text("\(streak)")
                    .font(.custom(FontsManager.Gemini_Moon.regular, size: 36))
                    .foregroundColor((Color(red: 163/255, green: 58/255, blue: 83/255)))
                    .padding()
                    .background(Circle().fill(Color(red: 255/255, green: 252/255, blue: 230/255)))
                    .overlay(
                        Circle()
                        .stroke(Color(red: 163/255, green: 58/255, blue: 83/255), lineWidth: 3))
                    .shadow(radius: 4, y: 5)

            }
            .padding()
            .background(Color(red: 89/255, green: 156/255, blue: 156/255))
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
            .shadow(radius: 4, y: 5)

        }
    }
}
