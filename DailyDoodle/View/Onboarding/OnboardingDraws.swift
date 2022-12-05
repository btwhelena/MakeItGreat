//
//  ContainerView.swift
//  DailyDoodle
//
//  Created by Ieda Xavier on 02/12/22.
//

import SwiftUI

struct OnboardingDraws: View {
    var body: some View {
            ZStack {
                Color("Text")
                VStack(spacing: 2 ) {
                    ZStack{
                        Image("DailyDoodle")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.height/3)
                            .foregroundColor(Color("Primary"))

                        Circle()
                            .strokeBorder(Color("Primary"), lineWidth: 4)
                            .frame(width: UIScreen.main.bounds.width/2.5, height: UIScreen.main.bounds.height/2.5)
                    }
                    Text("Desenhos")
                        .foregroundColor(Color("Primary"))
                        .font(.custom("Eri Serif", size: 42))
                        .multilineTextAlignment(.center)
                    Text("Você irá fazer desafios diários tentando reproduzir imagens de referência através dos desenhos.")
                        .foregroundColor(Color("Primary"))
                        .font(.custom("Eri Serif", size: 24))
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.main.bounds.width/1.5, height: 200)
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingDraws()
    }
}
