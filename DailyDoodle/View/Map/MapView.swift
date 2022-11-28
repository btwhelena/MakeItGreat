//
//  MapView.swift
//  DailyDoodle
//
//  Created by Maria Letícia Dutra de Oliveira on 23/11/22.
//

import SwiftUI

struct MapView: View {

    var body: some View {
        VStack {
            Spacer()
                .frame(height: CGFloat(50))
            LevelMap()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
