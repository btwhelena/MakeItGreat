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

    @State private var isPresented = false
    
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

                    Button(action: {isPresented.toggle()}) {
                        ReferenceImage()
                    }
                    .fullScreenCover(isPresented: $isPresented, content: FullScreenModalView.init)
                    
//                    NavigationLink(destination: FullPictureView(imagePath: UIImage(named: "CHALLENGE-\(DateHelper.getCurrentDay())")!)) {
//                        ReferenceImage()
//                    }
//
                }

            .navigationBarHidden(true)
            }
        .onAppear {
            isVisible.wrappedValue = false
        }
    }
}

extension DrawView {
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

struct FullScreenModalView: View {
    @Environment(\.dismiss) var dismiss
    @State private var offset: CGSize = CGSize(width: 0, height: 0)

    var body: some View {
                FullPictureView(imagePath: UIImage(named: "CHALLENGE-\(DateHelper.getCurrentDay())")!)
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
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
