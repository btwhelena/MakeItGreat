//
//  ShareButton.swift
//  DailyDoodle
//
//  Created by Helena Oliveira on 29/11/22.
//

import Foundation
import SwiftUI

struct ShareButton: View {
    @Binding var open: Bool
    var icon = "checkmark"
    var offsetX = 0
    var offsetY = 0
    var delay = 0.0

    var body: some View {
        Button(action: {
            share()
        }, label: {
            Image(systemName: icon)
                .foregroundColor(Theme.pinkCTA)
                .font(.system(size: 40, weight: .bold))
        })
        .padding()
        .mask(Circle())
        .offset(x: open ? CGFloat(offsetX) : 0, y: open ? CGFloat(offsetY) : 0)
        .scaleEffect(open ? 1 : 0)
        .animation(Animation.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0).delay(Double(delay)))
    }

    //PRECISA TROCAR O CONTEUDO PARA SER O DESENHO SALVO. ATUALMENTE ESTÁ UMA URL DE TESTE
    func share() {
            guard let urlShare = URL(string: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/cute-cat-photos-1593441022.jpg") else { return }
            let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
               UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        }
}

