//
//  MapView.swift
//  DailyDoodle
//
//  Created by Maria Letícia Dutra de Oliveira on 23/11/22.
//

import SwiftUI

struct MapView: View {

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

//            NavigationLink(destination: DrawView(), isActive: .constant(true)) {
//                EmptyView()
//            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
