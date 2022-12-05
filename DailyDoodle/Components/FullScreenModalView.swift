//
//  FullScreenModalView.swift
//  DailyDoodle
//
//  Created by Lais Godinho on 05/12/22.
//

import Foundation
import SwiftUI

struct FullScreenModalView: View {
    @Environment(\.dismiss) var dismiss
    @State private var offset: CGSize = CGSize(width: 0, height: 0)
    var image: UIImage

    init(image: UIImage) {
        self.image = image
    }
    
    var body: some View {
        FullPictureView(image: image)
            .background(BackgroundBlurView())
            .offset(offset)
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded({ value in
                    withAnimation {
                        offset = CGSize(width: 0, height: 0)
                    }
                    dismiss()
                }))
    }
}

struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
