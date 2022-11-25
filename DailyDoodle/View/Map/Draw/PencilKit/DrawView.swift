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

            VStack {
                HStack{
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

                    },
                           label: {
                        Image(systemName: "arrow.counterclockwise.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Theme.pinkCTA)

                    })

                    Spacer().frame(width: 225)

                    Button(action: {

                    },
                           label: {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Theme.pinkCTA)

                    })
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
