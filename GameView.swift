//
//  GameView.swift
//  Bangry irds
//
//  Created by Shivoy Arora on 18/04/23.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
        GeometryReader { reader in
            ZStack {
                // Background color
                Color.init(red: 255/255, green: 237/255, blue: 207/255)
                    .ignoresSafeArea()
                
                ZStack {
                    RealityKitView()
                        .environmentObject(modelData)
                        .padding()
                    
                    GameOverlay()
                        .environmentObject(modelData)
                    
                    if true {
                        Color.black
                            .ignoresSafeArea()
                            .opacity(0.20)
                        VStack {
                            HStack {
                                Spacer()
                                TutorialScreen()
                                    .environmentObject(modelData)
                                    .opacity(0.80)
                                    .padding(.top , reader.size.height / 9)
                                Spacer()
                            }
                            Spacer()
                        }

                        
                    }
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(ModelData.shared)
    }
}
