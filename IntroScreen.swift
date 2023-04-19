//
//  IntroScreen.swift
//  Bangry irds
//
//  Created by Shivoy Arora on 17/04/23.
//

import SwiftUI

struct IntroScreen: View {
    @EnvironmentObject var modelData: ModelData
    @AppStorage(StorageString.tutorialDone.rawValue) var tutDone: Bool = false
    @State private var centerText: Bool = true
    @State private var scale: CGFloat = 3.0
    @State private var para1Opacity: Double = 0
    @State private var para2Opacity: Double = 0
    
    init() {
        MyFont.registerFonts()
    }
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                // Background color
                Color.init(red: 255/255, green: 237/255, blue: 207/255)
                    .ignoresSafeArea()
                
                
                
                
                VStack {
                    Text("Bangry Irds")
                        .font(.custom("angrybirds-regular", size: 150).bold())
                        .scaleEffect(scale)
                        .foregroundColor(Color.init(red: 254/255, green: 109/255, blue: 115/255))
                        .minimumScaleFactor(0.01)
                        .scaledToFit()
                        .padding()
                        .offset(y: centerText ? reader.size.height/2 : 0)
                        .animation(.linear(duration: 1), value: centerText)
                        .animation(.linear(duration: 1), value: scale)
                    
                    Text("Get ready to experience a whole new level of fun and excitement as you embark on a journey to knock down blocks in a virtual world")
                        .font(.custom("angrybirds-regular", size: min(reader.size.width, reader.size.height) / 18, relativeTo: .body))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding([.leading, .trailing])
                        .opacity(para1Opacity)
                        .animation(.easeIn(duration: 0.5), value: para1Opacity)
                    
                    Text("This game challenges you to aim and hit the blocks in such a way that they all come crashing down. But with the added dimension of Augmented Reality, you'll feel like you're actually standing in the game world and launching your attacks in real-time")
                        .font(.custom("angrybirds-regular", size: min(reader.size.width, reader.size.height) / 18, relativeTo: .body))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding()
                        .opacity(para2Opacity)
                        .animation(.easeIn(duration: 0.5), value: para2Opacity)
                    
                    Spacer()
                    
                    // Play Button
                    Button {
                        if (!tutDone) {
                            modelData.currLevel = 0
                            tutDone = true
                            modelData.tutorial = true
                        }
                        
                        modelData.play = true
                    }label: {
                        Text(tutDone ? "Play" : "Start Tutorial")
                            .font(.custom("angrybirds-regular", size: min(reader.size.width, reader.size.height) / 15, relativeTo: .body))
                            .padding()
                            .foregroundColor(Color.init(red: 254/255, green: 249/255, blue: 239/255))
                            .background(content: {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(.init(red: 254/255, green: 166/255, blue: 170/255))
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.init(red: 248/255, green: 197/255, blue: 199/255), lineWidth: 10)
                                    }
                            })
                            .padding(reader.size.width / 30)
                            .opacity(para2Opacity)
                            .animation(.easeIn(duration: 0.5), value: para2Opacity)
                    }
                    .padding()
                }
                .onAppear() {
                    centerText = false
                    scale = 1
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.25, execute: {
                        para1Opacity = 1
                    })
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                        para2Opacity = 1
                    })
                }
            }
        }
    }
}

struct IntroScreen_Previews: PreviewProvider {
    static var previews: some View {
        IntroScreen()
    }
}
