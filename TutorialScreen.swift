//
//  TutorialScreen.swift
//  Bangry irds
//
//  Created by Shivoy Arora on 20/04/23.
//

import SwiftUI

struct TutorialScreen: View {
    @EnvironmentObject var modelData: ModelData
    
    @State private var step = 1
    var body: some View {
        GeometryReader { reader in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.init(red: 253/255, green: 215/255, blue: 155/255))
                
                VStack{
                    if step == 1 {
                        Text("In this game you have to shoot the blocks so that they fall off the platform. ")
                            .multilineTextAlignment(.leading)
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
                    }
                    else if step == 2 {
                        Text("The yellow square on the screen represents the focus. It needs to be stable before you tap the screen, else you wont see any output.")
                            .multilineTextAlignment(.leading)
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
                    }
                    else if step == 3 {
                        Text("Tap the screen to place the blocks, at the yellow square. ")
                            .multilineTextAlignment(.leading)
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
                    }
                    else if step == 4 {
                        Text("Tap the screen to shoot the ball to hit the blocks off the ground. ")
                            .multilineTextAlignment(.leading)
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
                    }
                    else if step == 5 {
                        Text("Once all the blocks are fallen off the ground, you will win the game. ")
                            .multilineTextAlignment(.leading)
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
                    }

                    
                    
//                    Spacer()
                    
                    // Next Button
                    HStack {
                        Spacer()
                        Button{
                            step += 1
                            if step == 6 {
                                modelData.tutorial = false
                            }
                        }label: {
                            Text(step == 5 ? "Finish" : "Next")
                            Image(systemName: "chevron.right")
                        }
                        .font(.title2)
                    }
                    .padding(.trailing)
                    .padding(.trailing)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    
                    // Showing steps number
                    HStack {
                        Spacer()
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: step == 1 ? 15 : 5, height: 5)
                            .foregroundColor(step == 1 ? .blue : .black)
                            .animation(.spring(), value: step)
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: step == 2 ? 15 : 5, height: 5)
                            .foregroundColor(step == 2 ? .blue : .black)
                            .animation(.spring(), value: step)
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: step == 3 ? 15 : 5, height: 5)
                            .foregroundColor(step == 3 ? .blue : .black)
                            .animation(.spring(), value: step)
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: step == 4 ? 15 : 5, height: 5)
                            .foregroundColor(step == 4 ? .blue : .black)
                            .animation(.spring(), value: step)
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: step == 5 ? 15 : 5, height: 5)
                            .foregroundColor(step == 5 ? .blue : .black)
                            .animation(.spring(), value: step)
                        
                        Spacer()
                    }
                    .padding()
                }
            }
            .frame(width: reader.size.width/1.2, height: reader.size.height / 5)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
        }
    }
}

struct TutorialScreen_Previews: PreviewProvider {
    static var previews: some View {
        TutorialScreen()
            .environmentObject(ModelData.shared)
    }
}
