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
                    .foregroundColor(Color("StreakTitle"))
                    .padding(.bottom, 5)

                Text("\(streak)")
                    .font(.custom(FontsManager.Gemini_Moon.regular, size: 36))
                    .foregroundColor(Color("StreakText"))
                    .padding()
                    .background(Circle().fill(Color("StreakBg")))
                    .overlay(
                        Circle()
                            .stroke(Color("StreakText"), lineWidth: 3))
                    .shadow(radius: 4, y: 5)

            }
            .padding()
            .background(Color("Streak"))
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
            .shadow(radius: 4, y: 5)

        }//.background(Color(red: 233/255, green: 252/255, blue: 230/255))
           // .frame(width: 200, height: 200)
            //.cornerRadius(5)
    }
}
