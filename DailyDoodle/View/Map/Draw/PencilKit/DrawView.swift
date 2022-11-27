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

struct DrawView_Previews: PreviewProvider {
    static var previews: some View {
        DrawView()
    }
}
