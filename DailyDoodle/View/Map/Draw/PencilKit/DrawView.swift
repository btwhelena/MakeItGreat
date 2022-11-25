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

    var body: some View {
        ZStack(alignment: .top){
            CanvasView(canvasView: $canvasView)
                .background(Color.black)
                .ignoresSafeArea()

            HStack{
                Button(action: {

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

struct DrawView_Previews: PreviewProvider {
    static var previews: some View {
        DrawView()
    }
}
