//
//  UserView.swift
//  DailyDoodle
//
//  Created by Maria Letícia Dutra de Oliveira on 23/11/22.
//

import SwiftUI

struct UserView: View {

    @State var vm = CloudKitUser()

    var body: some View {
        ZStack (alignment: .top){
            Color(red: 255/255, green: 252/255, blue: 230/255)

            Image("PinkBack")
                .resizable()
                .scaledToFit()

            VStack {
                Spacer().frame(height: 90)

                Image("avatar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 150)
                    .clipShape(Circle())
                    .shadow(radius: 4)

                Text("\(vm.userName)")
//                Text("Jorge")
                    .padding(.top, 10)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 22/255, green: 80/255, blue: 80/255))
                    .font(.custom(FontsManager.Eri_Serif.regular, size: 26))

                Spacer().frame(height: 70)

                HStack {
                    StreakCardView(title: "Streak Atual", streak: 10)
                    Spacer().frame(width: 30)
                    StreakCardView(title: "Maior Streak", streak: 13)
                }
            }
        }.ignoresSafeArea(.all)

    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
