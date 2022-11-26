//
//  GeminiTitle.swift
//  DailyDoodle
//
//  Created by Ieda Xavier on 26/11/22.
//

import SwiftUI

struct GeminiTitle: View {

    var title: String

    var body: some View {
        Text(title)
            .font(.custom("Gemini Moon", size: 38))
            .foregroundColor(.black)
            .padding(.vertical, 30)
            .frame(alignment: .top)
    }
}

