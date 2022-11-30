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
        ZStack {
            Circle()
                .fill(Theme.pinkCTA)
                .frame(width: 900, height: 900)
                .position(x: 200, y: -250)

            VStack{
                Image("snowman")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 150)
                    .clipShape(Circle())
                    .shadow(radius: 4)

                //Text("\(vm.userName)")
                Text("Jorge")
                    .padding(.top, 10)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .font(.custom(FontsManager.Eri_Serif.regular, size: 24))

                HStack {
                    StreakCardView(title: "Streak Atual", streak: 10)
                    Spacer().frame(width: 50)
                    StreakCardView(title: "Maior Streak", streak: 13)
                }
            }



        }.background(Color(red: 255/255, green: 252/255, blue: 230/255))

    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
