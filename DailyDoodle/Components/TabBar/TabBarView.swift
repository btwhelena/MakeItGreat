//
//  TabBarView.swift
//  DailyDoodle
//
//  Created by Maria Letícia Dutra de Oliveira on 23/11/22.

import SwiftUI
import Introspect

struct CustomBarVisibilityKey: EnvironmentKey {
    static let defaultValue = Binding(get: { true }, set: { _ in })
}

extension EnvironmentValues {
    var customBarIsVisible: Binding<Bool> {
        get { self[CustomBarVisibilityKey.self] }
        set { self[CustomBarVisibilityKey.self] = newValue }
    }
}

//TAB BAR ANIMADA
struct TabBar: View {
    @State var selectedtab = "map"
    @State var xAxis: CGFloat = 0
    @Namespace var animation

    @State var customTabBarIsVisible = true

    var body: some View {
        ZStack (
            alignment: Alignment(
                horizontal: .center,
                vertical: .bottom
            )
        ) {
            //MARK: Tabview atualiza a view de acordo com a tag
            TabView(selection: $selectedtab){
                MapView()
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("map")
                GalleryView()
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("gallery")
                UserView()
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("profile")
            }
            .environment(\.customBarIsVisible, $customTabBarIsVisible)

            //MARK: Configurações de imagens e botões para o que estiver selecionado
            if customTabBarIsVisible {
                makeCustomTabBar()
            }

        }
        .ignoresSafeArea(.all, edges: .bottom)

        .introspectTabBarController { (UITabBarController) in
            UITabBarController.tabBar.isHidden = true
        }
    }

    func makeCustomTabBar() -> some View {
        HStack(spacing: 0) {
            ForEach(icons, id: \.self){ image in
                GeometryReader { proxy in
                    Button(action: {
                        withAnimation(.spring()){
                            selectedtab = image
                            xAxis = proxy.frame(in: .global).minX
                        }
                    }, label: {
                        VStack {
                            Image(image)
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 40)
                                .foregroundColor(selectedtab == image ? getColor(image: image) : Color.accentColor)
                                .padding(selectedtab == image  ? 10 : 0)
                                .background(Color.accentColor.opacity(selectedtab == image  ? 1 : 0).clipShape(Circle()))
                                .matchedGeometryEffect(id: image, in: animation)
                                .offset(x: selectedtab == image ? (proxy.frame(in: .global).minX - proxy.frame(in: .global).midX) : 0, y: selectedtab == image  ? -60 : 0)

                            if selectedtab != image {
                                Text(image)
                                    .foregroundColor(Color.accentColor)
                                    .font(.custom(FontsManager.Eri_Serif.regular, size: 13))
                                    .fixedSize()
                            }
                        }.frame(height: 45)

                })
                    .onAppear(perform: {
                        if image == icons[1] {
                            xAxis = proxy.frame(in: .global).minX
                        }
                    })
                }
                .frame(width: 40, height: 40)

                if image != icons.last { Spacer(minLength: 0) }
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical)
        .background(Color("HeaderTitle").clipShape(CustomShape(xAxis: xAxis)).cornerRadius(25))
        .shadow(radius: 4)
        .padding(.horizontal)

        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
    }

    func getColor(image: String) -> Color{
        switch image {
        case "map":
            return Color(red: 255/255, green: 252/255, blue: 230/255)
        case "gallery":
            return Color(red: 255/255, green: 252/255, blue: 230/255)
        case "user":
            return Color(red: 255/255, green: 252/255, blue: 230/255)
        default:
            return Color(red: 255/255, green: 252/255, blue: 230/255)
        }
    }
}

var icons = ["gallery", "map", "profile"]

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
