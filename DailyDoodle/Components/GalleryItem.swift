//
//  GalleryItem.swift
//  DailyDoodle
//
//  Created by Lais Godinho on 05/12/22.
//

import SwiftUI

struct GalleryItem: View {
    @State private var isImageFullScreen: Bool = false
    var image: UIImage
    var currentDraw: BookModel

    var body: some View {

            Button(action: {isImageFullScreen.toggle()}) {
                ImageFull(image: image, book: currentDraw)
            }
            .fullScreenCover(isPresented: $isImageFullScreen, content: {FullScreenModalView(image: image)})
    }
}
