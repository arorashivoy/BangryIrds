//
//  IntroScreen.swift
//  Bangry irds
//
//  Created by Shivoy Arora on 17/04/23.
//

import SwiftUI

struct IntroScreen: View {
    init() {
        MyFont.registerFonts()
    }
    
    var body: some View {
        ZStack {
            // Background color
            Color.init(red: 23/255, green: 195/255, blue: 178/255)
                .ignoresSafeArea()
            
            VStack {
                Text("Bangry Irds")
                    .font(.custom("angrybirds-regular", size: 100))
                    .foregroundColor(Color.init(red: 255/255, green: 203/255, blue: 119/255))
                    .minimumScaleFactor(0.01)
                    .scaledToFit()
                    .padding([.leading, .trailing])
                    .padding([.leading, .trailing])
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            } 
        }
    }
}

struct IntroScreen_Previews: PreviewProvider {
    static var previews: some View {
        IntroScreen()
    }
}
