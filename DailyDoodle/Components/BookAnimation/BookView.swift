//
//  BookView.swift
//  DailyDoodle
//
//  Created by Ieda Xavier on 26/11/22.
//

import SwiftUI

struct BookView: View {

    @State var currentBook: Book = sampleBooks.first!

    var body: some View {
        BookSlider()
    }

    @ViewBuilder
    func BookSlider()->some View {
        TabView(selection: $currentBook) {
            ForEach(sampleBooks) { book in
                NavigationLink {
                    InfiniteCarrousel()
                } label: {
                    BookView(book: book)
                        .tag(book)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .background {
        }
    }

    @ViewBuilder
    func BookView(book: Book)->some View {

        GeometryReader {
            let size = $0.size

            let rect = $0.frame(in: .global)
            let minX = (rect.minX - 50) < 0 ? (rect.minX - 50) : -(rect.minX - 50)
            let progress = (minX) / rect.width
            let rotation = progress * 45

            ZStack {
                IsometricView(depth: 10){
                    Color.white
                } bottom: {
                    Color.white
                } side: {
                    Color.white
                }
                .frame(width: size.width / 1.2, height: size.height / 1.8)
                .shadow(color: .black.opacity(0.12), radius: 5, x: 15, y: -8)
                .shadow(color: .black.opacity(0.1), radius: 6, x: -10, y: -8)

                Image(systemName: "book.closed")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.width / 1.2, height: size.height / 1.8)
                    .clipped()
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 10, y: 8)
                    .foregroundColor(.black)

                //PAGINAS PASSANDO - ANIMAÇÃO
                    .rotation3DEffect(.init(degrees: rotation), axis: (x: 0, y: 1, z: 0), anchor: .leading, perspective: 1)
                    .modifier(CustomProjection(value: 1 + (-progress < 1 ? progress : -1.0)))

            }
            .offset(x: indexOf(book: book) > 0 ? -(progress * 45) : 0)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(50)

    }

    func indexOf(book: Book)->Int {
        if let index = sampleBooks.firstIndex(of: book){
            return index
        }
        return 0
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView()
    }
}
