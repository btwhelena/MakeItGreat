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


    var body: some View {
            ZStack {
                Color("Primary")
                VStack {
                    Spacer()
                    ReferenceImage(width: 400, height: 240)

                    Spacer().frame(height: 50)

                    Text("Try to draw the reference image in the app or upload it from your gallery")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("Text"))
                        .font(.custom(FontsManager.Eri_Serif.regular, size: 23))
                        .padding(.trailing, 50)
                        .padding(.leading, 50)

                    Spacer().frame(height: 100)

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
                        .font(.custom(FontsManager.Eri_Serif.regular, size: 20))
                        .bold()
                }
            }
            .ignoresSafeArea(.all, edges: .all)
            .onAppear {
                isVisible.wrappedValue = false
                image = UIImage(named: "snowman")!
            }
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
