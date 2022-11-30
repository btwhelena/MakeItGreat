//
//  ReferenceImage.swift
//  DailyDoodle
//
//  Created by Lais Godinho on 29/11/22.
//

import SwiftUI

struct ReferenceImage: View {
    var width: CGFloat = 200
    var height: CGFloat = 120
    var body: some View {
        Image("snowman")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height, alignment: .center)
            .clipShape(Circle())
    }
}

struct ReferenceImage_Previews: PreviewProvider {
    static var previews: some View {
        ReferenceImage()
    }
}
