//
//  Onboarding.swift
//  DailyDoodle
//
//  Created by Ieda Xavier on 03/12/22.
//

import SwiftUI

struct Onboarding: View {
    @StateObject var lnManager = LocalNotificationManager()
    @State var selectedtab = "home"
    @State var offset: CGFloat = 0
    
    var body: some View {
        NavigationView{
            ScrollView(.init()){
                ZStack (
                    alignment: Alignment(
                        horizontal: .center,
                        vertical: .bottom
                    )
                ) {
                    TabView(selection: $selectedtab){
                        HomeView()
                            .ignoresSafeArea(.all, edges: .all)
                            .tag("home")
                        OnboardingDraws()
                            .ignoresSafeArea(.all, edges: .all)
                            .tag("content")
                        OnboardingTime()
                            .ignoresSafeArea(.all, edges: .all)
                            .tag("container")
                            .environmentObject(lnManager)

                        if selectedtab == "home" {
                            HomeView()
                                .overlay (
                                    GeometryReader{ proxy->Color in
                                        let minX = proxy.frame(in: .global).minX

                                        DispatchQueue.main.async {
                                            withAnimation(.default) {
                                                self.offset = -minX
                                            }
                                        }

                                        return Color.clear

                                    }
                                        .frame(width: 0, height: 0)
                                )
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .overlay (
                        HStack(spacing:15){
                            ForEach(0..<3) {index in
                                Capsule()
                                    .fill(Color.white)
                                    .frame(width: getIndex() == index ? 20 : 7,height: 7)

                            }
                        }
                            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                        , alignment: .bottom

                    )

                }
                .ignoresSafeArea(.all, edges: .bottom)

            }
            .ignoresSafeArea(.all, edges: .all)
        }
        .task {
            try? await lnManager.requestNotification()
        }
        
    }

    func getIndex()->Int {
        let index = Int(round(Double(offset/getWidth())))

        return index
    }
}

extension View {
    func getWidth()->CGFloat {
        return UIScreen.main.bounds.width
    }
}
struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
