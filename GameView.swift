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
        ZStack {
            // Background color
            Color.init(red: 23/255, green: 195/255, blue: 178/255)
                .ignoresSafeArea()
            
            RealityKitView()
                .environmentObject(modelData)
                .edgesIgnoringSafeArea(.all)
            
            
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
