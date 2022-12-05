//
//  HomevIEW.swift
//  DailyDoodle
//
//  Created by Ieda Xavier on 02/12/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {

        ZStack {
            Color("Primary")
            HStack {
                Text("Vamos \nComeçar?")
                    .foregroundColor(Color("Text"))
                    .font(.custom("Eri Serif", size: 42))
                    .multilineTextAlignment(.leading)
                    .position(x: UIScreen.main.bounds.height/7,y: UIScreen.main.bounds.height/2)
                    .frame(width:UIScreen.main.bounds.width/1.9)

                ZStack{
                    Custombottom()
                        .fill(Color("Text"))
                    Image(systemName: "chevron.left")
                        .resizable()
                        .foregroundColor(Color("Primary"))
                        .frame(width: 30, height: 50)
                        .offset(x:UIScreen.main.bounds.width-380, y:-306)

                }
            }
        }
        .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct Custombottom: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.addArc(center: CGPoint(x: rect.minX+110, y: rect.minY+120), radius: rect.width/3, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)

        path.move(to: CGPoint(x: rect.minX+100, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX+100, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))

        return path
    }
}
