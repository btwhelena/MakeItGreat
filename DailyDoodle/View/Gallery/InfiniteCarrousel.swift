//
//  InfiniteCarrousel.swift
//  DailyDoodle
//
//  Created by Ieda Xavier on 26/11/22.
//

import SwiftUI

struct InfiniteCarrousel: View {

    @StateObject var vm = CloudKitCrudVM()
    @State var book: BookModel
    @State var currentIndex: Int = 0
    @State var fakeIndex: Int = 0
    @State var offset: CGFloat = 0

    var body: some View {
        

        VStack {

            TabView(selection: $fakeIndex){

                let drawsFiltered = vm.draws.filter { $0.nameTheme.contains(book.nameTheme) }

                ForEach(drawsFiltered) { currentDraw in
                    VStack(spacing: 18) {

                        if let url = currentDraw.imageURL, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                            NavigationLink {
                                ImageFull(image: image, book: currentDraw)
                            } label: {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    }
                    .padding(.horizontal,20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .cornerRadius(30)
                    .padding(.horizontal,50)
                    .overlay(
                        GeometryReader { proxy in
                            Color.clear.preference(key: OffsetKey.self, value: proxy.frame(in: .global).minX)
                        }
                    )
                    .onPreferenceChange(OffsetKey.self, perform: { offset in
                        self.offset = offset
                    })
                    .tag(getIndex(tab: currentDraw))

                    //DetailView(book: currentDraw)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 500)
        .padding(.bottom, 100)
        .background {
            Color("Primary")
        }
    }

    func indexOf(book: BookModel) -> Int {
        if let index = vm.draws.firstIndex(of: book){
            return index
        }
        return 0
    }

    @ViewBuilder
    func DetailView(book: BookModel)->some View {
        GeometryReader {
            let size = $0.size
            let index = indexOf(book: book)
            let currentIndex = 0
            
            VStack(alignment: .leading ){
                Text(" \(book.nameDetail)")
                    .font(.custom("Eri Serif", size: 32))
                    .foregroundColor(.gray)
                    .offset(x: CGFloat(currentIndex) * -(size.width + 30))
                    .opacity(currentIndex == index ? 1 : 0)
                    .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(currentIndex > index ? 0.1 : 0), value: currentIndex == index)
            }
            .frame(width: size.width + 30, alignment: .leading)
        }
        .padding(.horizontal, 20)
        .frame(height: 100)
        .padding(.bottom, 100)
        
    }
    func getIndex(tab: BookModel)->Int {
        let index = vm.draws.firstIndex { currentTab in
            return currentTab.id == tab.id
        } ?? 0

        return index
    }


}


struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


