import SwiftUI

struct HomeView: View {

    @State var offset : CGSize = .zero
    @State var showHome = false

    var body: some View {

        NavigationView {
            ZStack {
                Color("Text")

                .clipShape(LiquidSwipe(offset: offset))
                .ignoresSafeArea()
                .overlay(

                    Image(systemName: "chevron.left")
                        .font(.title.bold())
                        .foregroundColor(Color("Text"))
                        .frame(width: UIScreen.main.bounds.width * 0.12, height: UIScreen.main.bounds.height * 0.24)
                        .contentShape(Rectangle())
                        .gesture(DragGesture().onChanged({ (value) in

                            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)){
                                offset = value.translation
                            }

                        }).onEnded({(value) in

                            let screen = UIScreen.main.bounds

                            withAnimation(.spring()){

                                if -offset.width > screen.width / 2 {
                                    offset.width = -screen.height
                                    showHome.toggle()
                                } else {
                                    offset = .zero
                                }

                            }
                        }))
                        .offset(x: 15, y: -40)
                        .foregroundColor(.white)
                        .opacity(offset == .zero ? 1 : 0)

                    ,alignment: .topTrailing
                )
                .padding(.trailing)

                if showHome {
                    Onboarding()
                }

                VStack {

                    Spacer().frame(height: 120)
                    Text("Vamos começar?")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color("Primary"))
                        .font(.custom(FontsManager.Eri_Serif.regular, size: 35))
                        .padding(.trailing)
                        .offset(x: -15)
                        .gesture(DragGesture().onChanged({ (value) in

                            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)){
                                offset = value.translation
                            }

                        }).onEnded({(value) in

                            let screen = UIScreen.main.bounds

                            withAnimation(.spring()){

                                if -offset.width > screen.width / 2 {
                                    offset.width = -screen.height
                                    showHome.toggle()
                                } else {
                                    offset = .zero
                                }

                            }
                        }))
                        .offset(x: 15, y: -40)
                        .foregroundColor(Color("Text"))
                        .opacity(offset == .zero ? 1 : 0)

                    Spacer().frame(height: 100)

                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct LiquidSwipe: Shape {

    var offset : CGSize

    var animatableData: CGSize.AnimatableData {
        get{return offset.animatableData}
        set{offset.animatableData = newValue}
    }

    func path(in rect: CGRect) -> Path {
        return Path{path in


            let width = rect.width + (-offset.width >  0 ? offset.width : 0)

            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))

            let from = 80 + (offset.width)

            path.move(to: CGPoint(x: rect.width, y: from > 80 ? 80 : from))

            var to = 180 + (offset.height) + (-offset.width)
            to = to < 180 ? 180 : to

            let mid : CGFloat = 80 + ((to - 80) / 2)

            path.addCurve(to: CGPoint(x: rect.width, y: to), control1: CGPoint(x: width - 50, y: mid), control2: CGPoint(x: width - 50, y: mid))

        }
    }
}
