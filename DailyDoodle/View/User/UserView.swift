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
            Color("Primary")

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

//                Text("\(vm.userName)")
                Text("Ana Clara")
                    .padding(.top, 10)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("Text"))
                    .font(.custom(FontsManager.Eri_Serif.regular, size: 26))

                Spacer().frame(height: 70)

                HStack {
                    StreakCardView(title: "Current Streak", streak: 10)
                    Spacer().frame(width: 30)
                    StreakCardView(title: "Best Streak", streak: 13)
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
