//
//  GameView.swift
//  Bangry irds
//
//  Created by Shivoy Arora on 18/04/23.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var tapOpacity: Double = 0
    
    init() {
        MyFont.registerFonts()
    }
    
    var body: some View {
        RealityKitView()
            .environmentObject(modelData)
            .padding()
        
//        GeometryReader { reader in
//            ZStack {
//                // Background color
//                Color.init(red: 255/255, green: 237/255, blue: 207/255)
//                    .ignoresSafeArea()
//
//                ZStack {
//                    RealityKitView()
//                        .environmentObject(modelData)
//                        .padding()
//
//
//                    VStack {
//                        HStack {
//                            Text("Level: \(modelData.currLevel)")
//                                .font(.custom("angrybirds-regular", size: reader.size.width / 30, relativeTo: .body))
//                                .padding()
//                                .foregroundColor(Color.init(red: 254/255, green: 249/255, blue: 239/255))
//                                .background(content: {
//                                    RoundedRectangle(cornerRadius: 15)
//                                        .foregroundColor(.init(red: 254/255, green: 166/255, blue: 170/255))
//                                        .overlay{
//                                            RoundedRectangle(cornerRadius: 15)
//                                                .stroke(Color.init(red: 248/255, green: 197/255, blue: 199/255), lineWidth: 10)
//                                        }
//                                })
//                                .padding(reader.size.width / 30)
//
//                            Spacer()
//
//                            Text("Shoots: \(modelData.shootsLeft)")
//                                .font(.custom("angrybirds-regular", size: reader.size.width / 30, relativeTo: .body))
//                                .padding()
//                                .foregroundColor(Color.init(red: 254/255, green: 249/255, blue: 239/255))
//                                .background(content: {
//                                    RoundedRectangle(cornerRadius: 15)
//                                        .foregroundColor(.init(red: 254/255, green: 166/255, blue: 170/255))
//                                        .overlay{
//                                            RoundedRectangle(cornerRadius: 15)
//                                                .stroke(Color.init(red: 248/255, green: 197/255, blue: 199/255), lineWidth: 10)
//                                        }
//                                })
//                                .padding(reader.size.width / 30)
//
//
//                        }
//                        Spacer()
//
//                        Text(modelData.stageCreated ? "Tap To Shoot" : "Tap to Continue")
//                            .font(.custom("angrybirds-regular", size: reader.size.width / 20, relativeTo: .body))
//                            .foregroundColor(.white)
//                            .padding()
//                            .opacity(tapOpacity)
//                            .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: tapOpacity)
//                            .onAppear(perform: {
//                                tapOpacity = 1
//                            })
//                    }
//                }
//
//                if modelData.tutorial {
//
//                }
//
//
//            }
//        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(ModelData.shared)
    }
}
