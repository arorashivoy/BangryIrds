//
//  GameOverlay.swift
//  Bangry irds
//
//  Created by Shivoy Arora on 19/04/23.
//

import SwiftUI

struct GameOverlay: View {
    @EnvironmentObject var modelData: ModelData
    @State private var tapOpacity: Double = 0
    
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                HStack {
                    Text("Level: \(modelData.currLevel)")
                        .font(.custom("angrybirds-regular", size: min(reader.size.width, reader.size.height) / 30, relativeTo: .body))
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
                    
                    Spacer()
                    
                    Text("Shoots: \(modelData.shootsLeft)")
                        .font(.custom("angrybirds-regular", size: min(reader.size.width, reader.size.height) / 30, relativeTo: .body))
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
                    
                    
                }
                Spacer()
                
                Text(modelData.stageCreated ? "Tap To Shoot" : "Tap to Continue")
                    .font(.custom("angrybirds-regular", size: min(reader.size.width, reader.size.height) / 20, relativeTo: .body))
                    .foregroundColor(.white)
                    .padding()
                    .opacity(tapOpacity)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: tapOpacity)
            }
            .onAppear(perform: {
                tapOpacity = 1
            })
            
        }
    }
}

struct GameOverlay_Previews: PreviewProvider {
    static var previews: some View {
        GameOverlay()
    }
}
