//
//  ViewRoutter.swift
//  DailyDoodle
//
//  Created by Ieda Xavier on 05/12/22.
//

import Foundation

class ViewRouter: ObservableObject {
    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            currentPage = "onboardingView"
        } else {
            currentPage = "homeView"
        }
    }

    @Published var currentPage: String

}
