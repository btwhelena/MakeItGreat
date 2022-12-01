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
                    Spacer()
                        .frame(height: CGFloat(50))
                    LevelMap()
                }
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
