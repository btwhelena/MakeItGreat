//
//  GalleryDetailView.swift
//  DailyDoodle
//
//  Created by Ieda Xavier on 29/11/22.
//

import SwiftUI

struct GalleryDetailView: View {
    @State var book: BookModel

    var body: some View {
        GeminiTitle(title: book.nameTheme)
        InfiniteCarrousel(book: book)
    }
}
