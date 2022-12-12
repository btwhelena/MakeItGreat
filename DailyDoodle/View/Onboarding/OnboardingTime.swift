//
//  DailyDoodle
//
//  Created by Ieda Xavier on 02/12/22.
//

import SwiftUI

struct OnboardingTime: View {
    @EnvironmentObject var lnManager : LocalNotificationManager
    @State private var scheduleDate = Date()
    var body: some View {
            ZStack {
                Color("Primary")
                VStack(alignment: .center, spacing: 2 ) {

                    Text("Cronograma")
                        .foregroundColor(Color("Text"))
                        .font(.custom("Eri Serif", size: 42))
                        .multilineTextAlignment(.center)
                    Text("Escolha seu horário favorito para desenhar")
                        .foregroundColor(Color("Text"))
                        .font(.custom("Eri Serif", size: 24))
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.main.bounds.width/1.5, height: 150)

                    DatePicker("", selection: $scheduleDate, displayedComponents: .hourAndMinute)
                        .multilineTextAlignment(.center)
                        .labelsHidden()
                        .padding(.bottom, 50)

                    NavigationLink {
                        TabBar()
                            .task {
                                let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: scheduleDate)
                                let notification = LocalNotification(identifier: UUID().uuidString, title: "Daily Doodle", body: "It's time to draw some doodles!", dateComponents: dateComponents, repeats: true)
                                try? await lnManager.schedule(localNotification: notification)
                            }
                    } label: {
                        ZStack(alignment: .center) {

                            Rectangle()
                                .frame(width: 153, height: 40)
                                .cornerRadius(30)
                                .foregroundColor(Color("AccentColor"))

                            Text("Iniciar")
                                .foregroundColor(Color("HeaderTitle"))
                                .font(.custom("Eri Serif", size: 24))
                                .multilineTextAlignment(.center)
                        }
                    }
                }
            }
            .ignoresSafeArea(.all, edges: .all)
            .task {
                try? await lnManager.requestNotification()
            }
    }
}

struct ContentViewBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingTime()
    }
}
