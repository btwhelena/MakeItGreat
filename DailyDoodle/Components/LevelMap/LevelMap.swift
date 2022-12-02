//
//  LevelMap.swift
//  DailyDoodle
//
//  Created by Lais Godinho on 25/11/22.
//

import SwiftUI

struct LevelMap: View {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Spacer()
                    .frame(height: CGFloat(200))
                ForEach(Challenge.mockedChallenges.reversed()) { challenge in
                    challenge.view
                }
                Spacer()
                    .frame(height: CGFloat(200))
            }
            .frame(width: screenWidth)
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

    init() {
        let screenWidth = UIScreen.main.bounds.width
        Challenge.createdDays += 1
        self.day = Challenge.createdDays
        let currentDay = DateHelper.getCurrentDay()
        let initialPosition = CGFloat(300)
        var currentY = CGFloat(80) //initialPosition * CGFloat(currentDay - self.day)

        let color = self.day == DateHelper.getCurrentDay() ? Color("AccentColor") : Color("Secondary")
        let strokeStyle = self.day <= DateHelper.getCurrentDay() ? StrokeStyle(lineWidth: 10) : StrokeStyle(lineWidth: 10, dash: [10])
        let isButtonDisabled = self.day > DateHelper.getCurrentDay() ? true : false

        if Challenge.lastPosition != nil {
            currentY = Challenge.lastPosition!.y - 8

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
