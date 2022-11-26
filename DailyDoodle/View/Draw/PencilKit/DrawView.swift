//
//  DrawView.swift
//  DailyDoodle
//
//  Created by Helena Oliveira on 25/11/22.
//
import SwiftUI
import PencilKit

struct DrawView: View {

    @State private var canvasView = PKCanvasView()
    @State private var image: UIImage = UIImage()
    @State var previewDrawing: PKDrawing? = nil
    @StateObject private var vm = CloudKitCrudVM()
    @StateObject private var authenticate = CloudKitUser()

    var body: some View {
        ZStack(alignment: .top){
            CanvasView(canvasView: $canvasView)
                .background(Color.black)
                .ignoresSafeArea()

            HStack{
                Button(action: {
                    onClearTapped()
                },
                       label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color.black)

                })

                Spacer().frame(width: 225)

                Button(action: {
                    onSaved()
                },
                       label: {
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color.black)

                })
            }

        }
    }
}

private extension DrawView {
    func onClearTapped(){
        canvasView.drawing = PKDrawing()
    }

    func onUndoTapped(){
        guard let preview = previewDrawing else { return }
        canvasView.drawing = preview
    }

    func onSaved() {
        if !canvasView.drawing.bounds.isEmpty {
            image = canvasView.drawing.image(from: canvasView.bounds, scale: UIScreen.main.scale)
            previewDrawing = canvasView.drawing
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            vm.addItem(image: image)
        }
    }
}

struct DrawView_Previews: PreviewProvider {
    static var previews: some View {
        DrawView()
    }
}
