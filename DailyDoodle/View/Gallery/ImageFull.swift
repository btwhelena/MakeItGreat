//
//  ImageFull.swift
//  DailyDoodle
//
//  Created by Ieda Xavier on 30/11/22.
//

import SwiftUI

struct ImageFull: View {

    var image: UIImage
    var book: BookModel

    var body: some View {
            ZStack {
                    FullPictureView(image: image)
            }
            .ignoresSafeArea(.all, edges: .all)
    }
}
