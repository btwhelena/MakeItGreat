//
//  LoginScreenPOC.swift
//  ICloudyPOC
//
//  Created by Ieda Xavier on 24/11/22.
//

import SwiftUI
import LocalAuthentication

struct LoginScreen: View {
    @StateObject private var vm = CloudKitUser()
    @StateObject private var vr = ViewRouter()
    @State var isUnlock : Bool = false

    var body: some View {
        VStack{
            if isUnlock {
                MotherView()
                    .environmentObject(vr)

            } else {
                LockView()
            }
        }
        .onAppear(){
            DispatchQueue.main.async {
//                isUnlock = vm.isSignedInToICloud
                isUnlock = true
            }
        }
    }
}
