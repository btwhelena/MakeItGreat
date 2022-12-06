//
//  Home.swift
//  POC Book Animation
//
//  Created by Maria Letícia Dutra de Oliveira on 22/11/22.
//

import SwiftUI

struct GalleryView: View {
    @StateObject var vm = CloudKitCrudVM()

    var body: some View {
            NavigationView{
                ZStack {
                    Color("Primary")
                VStack {
                    ZStack {
                        Image("PinkHeader")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color("AccentColor"))
                            .shadow(radius: 4, y: 5)
                        GeminiTitle(title: "Gallery")
                            .padding(.top, 1)
                    }
                    BookSlider()
                    GalleryThemeView()
                        .padding(.bottom, 50)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

            }
                .ignoresSafeArea(.all, edges: .all)
        }
    }

    @ViewBuilder
    func GalleryThemeView()->some View {
        VStack {
            GeometryReader {
                let size = $0.size

                HStack(spacing: 0){
                    ForEach(vm.draws) { book in
                        let index = indexOf(book: book)
                        let currentIndex = indexOf(book: vm.selectedDraw ?? vm.draws.first!)

                        VStack(alignment: .leading, spacing: 18) {
                            Text(book.nameTheme)
                                .font(.custom(FontsManager.Eri_Serif.regular, size: 30))
                                .foregroundColor(Color("Text").opacity(0.7))
                                .offset(x: CGFloat(currentIndex) * -(size.width + 11))
                                .opacity(currentIndex == index ? 1 : 0)
                                .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(currentIndex < index ? 0.1 : 0), value: currentIndex == index)

                        }
                        .frame(width: size.width + 11, alignment: .trailing)
                    }
                }
            }
            .padding(.horizontal, 15)
            .frame(height: 100)
            .padding(.bottom, 10)

        }
    }

    @ViewBuilder
    func BookSlider()->some View {
        TabView(selection: $vm.selectedDraw) {
            ForEach(vm.draws.uniqued()) { book in
                if !vm.draws.uniqued().isEmpty{
                    NavigationLink {
                        GalleryDetailView(book: book)
                    } label: {
                        BookView(book: book)
                    }
                    .tag(Optional(book))
                } else {
                    Text("Ops! Try to draw in map session to start")
                        .font(.custom("Eri Serif", size: 26))
                        .foregroundColor(Color("Text"))
                        .multilineTextAlignment(.center)
                }

            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }

    @ViewBuilder
    func BookView(book: BookModel)->some View {
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
                .frame(width: size.width / 1.2, height: size.height / 1.5)
                .shadow(color: .black.opacity(0.12), radius: 5, x: 15, y: -8)
                .shadow(color: .black.opacity(0.1), radius: 6, x: -10, y: -8)

                Image("\(book.nameTheme)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width / 1.2, height: size.height / 1.5)
                    .clipped()
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 10, y: 8)

                //PAGINAS PASSANDO - ANIMAÇÃO
                    .rotation3DEffect(.init(degrees: rotation), axis: (x: 0, y: 1, z: 0), anchor: .leading, perspective: 1)
                    .modifier(CustomProjection(value: 1 + (-progress < 1 ? progress : -1.0)))
            }
            .offset(x: indexOf(book: book) > 0 ? -(progress * 45) : 0)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(.horizontal, 50)
    }

    func indexOf(book: BookModel) -> Int {
        if let index = vm.draws.firstIndex(of: book){
            return index
        }
        return 0
    }

}

extension Array where Element == BookModel {
    func uniqued() -> [Element] {
        var filtered = [BookModel]()
        for model in self {
            if filtered.contains(where: { $0.nameTheme == model.nameTheme }) {
                continue
            } else {
                filtered.append(model)
            }
        }
        return filtered
    }
}
