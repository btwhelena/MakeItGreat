//
//  Level.swift
//  DailyDoodle
//
//  Created by Lais Godinho on 25/11/22.
//

import SwiftUI

struct LevelView: View {
    let label: String
    let position: CGPoint
    let previousPosition: CGPoint
    var color = Color("Secondary")
    var strokeStyle = StrokeStyle(lineWidth: 10, dash: [10])
    var isButtonDisabled: Bool = false
    @State private var isPresented = false

    var body: some View {
//            Text("\(didStartChallenge)")
            ZStack {

                Path { path in
                    path.move(to: CGPoint(x: position.x, y: position.y + 48))
                    path.addLine(to: CGPoint(x: previousPosition.x, y: previousPosition.y + 160))
                }
                .stroke(style: strokeStyle)
                .foregroundColor(Color("Secondary"))
                Button(action: {action()}) {
                    ZStack {
                        color
                        Text(label).foregroundColor(.white)
                    }
                }
                .disabled(isButtonDisabled)
                .frame(width: 48, height: 48)
                .cornerRadius(24)
                .position(position)
                .padding([.vertical], 32)
                .sheet(isPresented: $isPresented) {
                    TodayChallengeView(isPresented: $isPresented)
                }

            }
    }

    func action() {
        if Int(label)! == DateHelper.getCurrentDay() {
            isPresented.toggle()
        }
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView(label: "Test", position: CGPoint(x: 50, y: 50), previousPosition: CGPoint(x: 50, y: 50))
    }
}
