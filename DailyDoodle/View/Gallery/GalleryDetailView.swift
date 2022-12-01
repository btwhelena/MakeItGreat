//
//  GalleryDetailView.swift
//  DailyDoodle
//
//  Created by Ieda Xavier on 29/11/22.
//

import SwiftUI

struct GalleryDetailView: View {
    @State var book: BookModel
    @StateObject var vm = CloudKitCrudVM()

    var body: some View {
        GeminiTitle(title: book.nameTheme)
            .padding(.top, 20)
        InfiniteCarrousel(book: book)
    }
}
