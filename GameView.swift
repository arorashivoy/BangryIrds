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
                    
                    if modelData.tutorial {
                        VStack {
                            TutorialScreen()
                                .environmentObject(modelData)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .opacity(0.80)
                                .padding(.top , reader.size.height / 10)
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
