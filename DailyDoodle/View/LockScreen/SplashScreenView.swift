//
//  SplashScreenView.swift
//  DailyDoodle
//
//  Created by Ieda Xavier on 02/12/22.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5

    var body: some View {

        NavigationView {

            if isActive {
                LoginScreen()
            } else {
                ZStack{
                    Color("Primary")
                    VStack {

                        Image("DailyDoodle")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/2)
                            .foregroundColor(Color("Text"))

                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 1.2)){
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                }
                .ignoresSafeArea()
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        withAnimation{
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
