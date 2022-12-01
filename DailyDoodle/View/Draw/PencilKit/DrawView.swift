//
//  DrawView.swift
//  DailyDoodle
//
//  Created by Helena Oliveira on 25/11/22.
//
import SwiftUI
import PencilKit


//MARK: DRAW SCREEN FOR DAILY CHALLENGES
struct DrawView: View {

    @Environment(\.customBarIsVisible) var isVisible
    @Environment(\.presentationMode) var presentation

    @State private var canvasView = PKCanvasView()
    @State private var image: UIImage = UIImage()
    @State var previewDrawing: PKDrawing? = nil
    @StateObject private var vm = CloudKitCrudVM()
    @State var labelHeight = CGFloat.leastNonzeroMagnitude
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            CanvasView(canvasView: $canvasView)
                .background(Color.black)
                .ignoresSafeArea()

                VStack {
                    HStack (spacing: 9){
                        Spacer().frame(width: 150)
                        CloseButton(action: onCloseTapped)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        UndoButton()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer().frame(width: 170)
                        OtherButton()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                    }.frame(width: UIScreen.main.bounds.width, height: labelHeight + 50, alignment: .center)
                    
                    ReferenceImage()
                    
                }

            .navigationBarHidden(true)
            }
        .onAppear {
            isVisible.wrappedValue = false
        }
        }
    }
//}

private extension DrawView {
    func onCloseTapped() {
        presentation.wrappedValue.dismiss()
    }
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
            vm.addItem(nameTheme:"Natal", nameDetail:"Velas",image: image)
        }
    }
}

struct DrawView_Previews: PreviewProvider {
    static var previews: some View {
        DrawView()
    }
}
