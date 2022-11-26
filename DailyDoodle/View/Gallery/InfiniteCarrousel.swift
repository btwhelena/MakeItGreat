//
//  InfiniteCarrousel.swift
//  DailyDoodle
//
//  Created by Ieda Xavier on 26/11/22.
//

import SwiftUI

struct InfiniteCarrousel: View {

    @State var vm = CloudKitCrudVM()
    @State var currentIndex: Int = 0
    @State var fakeIndex: Int = 0
    @State var offset: CGFloat = 0

    var body: some View {

        VStack{

            TabView(selection: $fakeIndex){
                ForEach(vm.draw) { currentDraw in
                    VStack(spacing: 18) {
                        if let url = currentDraw.imageURL, let data = try? Data(contentsOf: url), let image = UIImage(data: data){
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()

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
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 450)
            .padding(.bottom, 60)
            .onChange(of: offset) { newValue in

                if fakeIndex == 0 && offset == 0{
                    fakeIndex = vm.draw.count - 2
                }

                if fakeIndex == vm.draw.count - 1 && offset == 0{
                    fakeIndex = 1
                }
            }
            .onAppear{
                guard var first = vm.draw.first else { return }

                guard var last = vm.draw.last else { return }

                first.id = UUID().uuidString
                last.id = UUID().uuidString

                vm.draw.append(first)
                vm.draw.insert(last, at: 0)

                fakeIndex = 1
            }

        }
    }
    func getIndex(tab: DrawModel)->Int {
        let index = vm.draw.firstIndex { currentTab in
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


