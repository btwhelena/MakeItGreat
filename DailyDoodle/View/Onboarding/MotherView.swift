//
//  MotherView.swift
//  DailyDoodle
//
//  Created by Ieda Xavier on 05/12/22.
//

import SwiftUI

struct MotherView : View {

    @EnvironmentObject var viewRouter: ViewRouter

    var body: some View {
        VStack {
            if viewRouter.currentPage == "onboardingView" {
                Onboarding()
            } else if viewRouter.currentPage == "homeView" {
                TabBar()
            }
        }
    }
}
struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}
