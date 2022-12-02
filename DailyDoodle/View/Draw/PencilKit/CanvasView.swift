//
//  CanvasView.swift
//  DailyDoodle
//
//  Created by Helena Oliveira on 25/11/22.
//
import Foundation
import PencilKit
import SwiftUI

struct CanvasView: UIViewRepresentable {

    @Binding var canvasView: PKCanvasView
    @State var tool = PKToolPicker()

    func makeUIView(context: Context) -> some UIView {
        canvasView.tool = PKInkingTool(.pen, color: .red, width: 50)
        canvasView.drawingPolicy = .anyInput
        showTools()
        return canvasView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }
}

private extension CanvasView {
    func showTools() {
        tool.setVisible(true, forFirstResponder: canvasView)
        tool.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }
}

