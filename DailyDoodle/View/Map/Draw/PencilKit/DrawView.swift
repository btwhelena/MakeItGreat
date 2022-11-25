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
    @Environment(\.undoManager) private var undoManager

    var body: some View {
        ZStack(alignment: .topTrailing){
            CanvasView(canvasView: $canvasView)
                .background(Color.black)
                .ignoresSafeArea()

            VStack {
                HStack {
                    Button(action: {

                    },
                           label: {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Theme.pinkCTA)

                    })
                    Spacer().frame(width: 20)

                    Button(action: {
                        undoManager?.undo()
                    },
                    label: {
                        Image(systemName: "arrow.counterclockwise.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Theme.pinkCTA)

                    })
                    Spacer().frame(width: 130)
                    OtherButton()
                }

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
