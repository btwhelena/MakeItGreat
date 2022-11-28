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
    
    @State private var canvasView = PKCanvasView()
    @State private var image: UIImage = UIImage()
    @State var previewDrawing: PKDrawing? = nil
    @StateObject private var vm = CloudKitCrudVM()
    @StateObject private var authenticate = CloudKitUser()
    @State var labelHeight = CGFloat.leastNonzeroMagnitude
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            CanvasView(canvasView: $canvasView)
                .background(Color.black)
                .ignoresSafeArea()

                VStack {
                    HStack (spacing: 9){
                        Spacer().frame(width: 150)
                        CloseButton()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        UndoButton()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer().frame(width: 170)
                        OtherButton()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                    }.frame(width: UIScreen.main.bounds.width, height: labelHeight + 50, alignment: .center)
                    
                    Image("snowman")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 120,alignment: .center)
                        .clipShape(Circle())
                    
                }
                
            }
        }
    }
//}

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
