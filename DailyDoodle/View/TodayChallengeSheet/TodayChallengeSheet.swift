//
//  TodayChallengeView.swift
//  DailyDoodle
//
//  Created by Lais Godinho on 25/11/22.
//

import SwiftUI

struct TodayChallengeView: View {
    @Binding var isPresented: Bool
    @State var isImagePickerVisible = false
    @State var inputImage: UIImage?
    @State var isActive = false

    init(isPresented: Binding<Bool>) {
        UINavigationBar.appearance().backgroundColor = UIColor(named: "Primary")
        self._isPresented = isPresented
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color("Primary")
                VStack {
                    ReferenceImage(width: 400, height: 240)
                    Spacer()
                    CustomButton(title: "Start Challenge", action: startChallenge)
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
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: dismissSheet) {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.gray)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Today's Challenge")
                        .foregroundColor(Color("Text"))
                }
            }
        }
    }

    func dismissSheet() {
        isPresented = false
    }

    func startChallenge() {
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
