//
//  LevelMap.swift
//  DailyDoodle
//
//  Created by Lais Godinho on 25/11/22.
//

import SwiftUI

struct LevelMap: View {

    private let initialPosition = "challenge-\(DateHelper.getCurrentDay())"
    
    var body: some View {
        VStack {
//            Spacer()
//                .frame(height: CGFloat(50))

                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        VStack {
                            ForEach(Challenge.mockedChallenges.reversed()) { challenge in
                                challenge.view
                            }
                            Spacer()
                                .frame(height: CGFloat(200))
                        }
                    }
                    .onAppear {
                        proxy.scrollTo(initialPosition)
                    }
                }
        }
    }

    func action() {

    }
}

struct LevelMap_Previews: PreviewProvider {
    static var previews: some View {
        LevelMap()
    }
}

class Challenge: Identifiable {

    static var createdDays: Int = 0
    static var lastPosition: CGPoint?
    var day: Int = 0
    let view: LevelView
    var isCurrentDay: Bool

    init() {
        let screenWidth = UIScreen.main.bounds.width
        Challenge.createdDays += 1
        self.day = Challenge.createdDays
        let currentDay = DateHelper.getCurrentDay()
        self.isCurrentDay = self.day == currentDay
        //        let initialPosition = CGFloat(300)
        var currentY = CGFloat(80) //initialPosition * CGFloat(currentDay - self.day)

        let color = self.day == DateHelper.getCurrentDay() ? Color("AccentColor") : Color("Secondary")
        let strokeStyle = self.day <= DateHelper.getCurrentDay() ? StrokeStyle(lineWidth: 10) : StrokeStyle(lineWidth: 10, dash: [10])
        let isButtonDisabled = self.day > DateHelper.getCurrentDay() ? true : false

        if Challenge.lastPosition != nil {
            currentY = Challenge.lastPosition!.y

            let currentPosition = CGPoint(x: CGFloat.random(in: 24...(screenWidth-56)), y: currentY)

            self.view = LevelView(
                label: String(self.day),
                position: currentPosition,
                previousPosition: Challenge.lastPosition!,
                color: color,
                strokeStyle: strokeStyle,
                isButtonDisabled: isButtonDisabled)

            Challenge.lastPosition = currentPosition
        } else {
            let currentPosition = CGPoint(x: CGFloat.random(in: 24...(screenWidth-56)), y: currentY)

            self.view = LevelView(
                label: String(self.day),
                position: currentPosition,
                previousPosition: currentPosition,
                color: color,
                strokeStyle: strokeStyle,
                isButtonDisabled: isButtonDisabled)

            Challenge.lastPosition = currentPosition
        }

    }

    static let mockedChallenges = generateChallenges()

    static private func generateChallenges() -> [Challenge] {
        let daysInMonth = DateHelper.daysInMonth(date: Date())

        var challenges: [Challenge] = []
        for _ in 1...daysInMonth {
            challenges.append(Challenge())
        }

        return challenges
    }
}
