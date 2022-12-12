//
//  MapView.swift
//  DailyDoodle
//
//  Created by Maria Letícia Dutra de Oliveira on 23/11/22.
//

import SwiftUI

struct MapView: View {

    @Environment(\.customBarIsVisible) var isVisible

    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(named: "Primary")
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Primary")
                VStack {
                    ZStack {
                        LevelMap()
                        Image("PinkHeader")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color("AccentColor"))
                            .shadow(radius: 4, y: 5)
                            .frame(height: 850, alignment: .top)
                        GeminiTitle(title: "Map")
                            .padding(.top, 1)
                            .frame(height: 750, alignment: .top)
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .ignoresSafeArea(.all, edges: .all)
            .onAppear {
                withAnimation {
                        isVisible.wrappedValue = true
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
