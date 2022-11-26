//
//  GalleryView.swift
//  DailyDoodle
//
//  Created by Maria Letícia Dutra de Oliveira on 23/11/22.
//

import SwiftUI

struct GalleryView: View {
    
    @State var currentIndex: Int = 0
    @State var showDraws: Bool = false

    var body: some View {
        NavigationView {
            VStack {

                Spacer()

                GeminiTitle(title: "Galeria")

                BookView()

            }
        }
    }
}

