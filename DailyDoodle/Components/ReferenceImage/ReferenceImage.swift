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

    @State var image: UIImage? = UIImage(named: "snowman")!

    var body: some View {
        if let image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height, alignment: .center)
                .clipShape(Circle())
        } else {
            Text("Loading Image")
                .task {
                    DispatchQueue.main.async {
                        image = UIImage(named: "snowman")!
                    }
                }
        }
    }
}

//struct ReferenceImage_Previews: PreviewProvider {
//    static var previews: some View {
//        ReferenceImage()
//    }
//}
