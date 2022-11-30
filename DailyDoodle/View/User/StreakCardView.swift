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
                    .foregroundColor(Color(red: 255/255, green: 252/255, blue: 230/255))
                    .padding(.bottom,5)

                Text("\(streak)")
                    .font(.custom(FontsManager.Gemini_Moon.regular, size: 24))
                    .padding()
                    .background(Color(red: 255/255, green: 252/255, blue: 230/255))
                    .clipShape(Circle())

            }
            .padding()
            .background(Color(red: 89/255, green: 156/255, blue: 156/255))
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))

        }//.background(Color(red: 233/255, green: 252/255, blue: 230/255))
           // .frame(width: 200, height: 200)
            //.cornerRadius(5)
    }
}
