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
    var color = Color.mint
    var strokeStyle = StrokeStyle(lineWidth: 10, dash: [10])
    var isButtonDisabled: Bool = false
    @State private var showingSheet = false

    var body: some View {
        ZStack {

            Path { path in
                path.move(to: CGPoint(x: position.x, y: position.y + 48))
                path.addLine(to: CGPoint(x: previousPosition.x, y: previousPosition.y + 160))
            }
            .stroke(style: strokeStyle)
            .foregroundColor(.mint)
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
            .sheet(isPresented: $showingSheet) {
                TodayChallengeSheet()
            }
        }
    }

    func action() {
        if Int(label)! == DateHelper.getCurrentDay() {
            showingSheet.toggle()
        }
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView(label: "Test", position: CGPoint(x: 50, y: 50), previousPosition: CGPoint(x: 50, y: 50))
    }
}
