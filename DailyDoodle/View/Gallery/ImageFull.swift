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
        NavigationView {
            ZStack {
                    FullPictureView(imagePath: image)
            }
            .ignoresSafeArea(.all, edges: .all)
        }
        .navigationTitle(book.nameDetail)
        .font(.custom("Eri Serif", size: 16))
    }
}
