//
//  Stepper.swift
//  DailyDoodle
//
//  Created by Lais Godinho on 24/11/22.
//

import SwiftUI
import StepperView

struct Stepper: View {
    
    var body: some View {
        ScrollView {
            VStack {
                StepperView()
                        .addSteps(steps)
                        .indicators(indicationTypes)
                        .stepIndicatorMode(StepperMode.vertical)
                        .spacing(30)
                        .lineOptions(StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
                Spacer()
                    .frame(height: 150)
            }
        }
    }
}

struct Stepper_Previews: PreviewProvider {
    static var previews: some View {
        Stepper()
    }
}
