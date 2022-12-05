import SwiftUI

struct LockView: View {
    var body: some View {
        ZStack {
            Color("Primary")
            VStack{
                LottieView(lottie: "94992-error-404")
                    .frame(width: 300, height: 300)

                Text("Error\n\n ICloud Account\n Not Found")
                    .foregroundColor(Color("Text"))
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 80)
                    .multilineTextAlignment(.center)

            }
        }
        .ignoresSafeArea(.all, edges: .all)
    }
}
