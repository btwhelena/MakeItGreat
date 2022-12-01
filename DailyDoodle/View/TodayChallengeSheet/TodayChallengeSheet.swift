//
//  TodayChallengeView.swift
//  DailyDoodle
//
//  Created by Lais Godinho on 25/11/22.
//

import SwiftUI

struct TodayChallengeView: View {

    @Environment(\.customBarIsVisible) var isVisible

    @Binding var isPresented: Bool
    @State var isImagePickerVisible = false
    @State var inputImage: UIImage?
    @State var isActive = false

    @State var image: UIImage = UIImage(named: "snowman")!

//    init(isPresented: Binding<Bool>) {
//        UINavigationBar.appearance().backgroundColor = UIColor(named: "Primary")
//        self._isPresented = isPresented
//    }

    var body: some View {
            ZStack {
                Color("Primary")
                VStack {
                    Spacer()
                    ReferenceImage(width: 400, height: 240)
                    Spacer()
                    NavigationLink(destination: DrawView(), isActive: $isActive) {
                        CustomButton(title: "Start Challenge", action: startChallenge)
                    }
                    CustomButton(title: "Choose from gallery",
                                 backgroundColor: Color.clear,
                                 foregroundColor: Color.accentColor,
                                 action: chooseFromGallery)
                    .sheet(isPresented: $isImagePickerVisible) {
                        ImagePicker(image: $inputImage)
                    }
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Today's Challenge")
                        .foregroundColor(Color("Text"))
                        .font(.custom(FontsManager.Eri_Serif.regular, size: 17))
                }
            }
            .ignoresSafeArea(.all, edges: .all)
            .onAppear {
                isVisible.wrappedValue = false
                image = UIImage(named: "snowman")!
            }
//            .onDisappear {
//                withAnimation {
//                    isVisible.wrappedValue = true
//                }
//            }
    }

    func dismissSheet() {
        isPresented = false
    }

    func startChallenge() {
        isActive.toggle()
    }

    func chooseFromGallery() {
        isImagePickerVisible.toggle()
    }
}

struct TodayChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        TodayChallengeView(isPresented: .constant(true))
    }
}
