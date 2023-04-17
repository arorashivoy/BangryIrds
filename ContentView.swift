import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        // TODO: add a warning that the focus entity should be stable
        if (!modelData.play) {
            IntroScreen()
                .environmentObject(modelData)
        }
        else {
            RealityKitView()
                .environmentObject(modelData)
                .edgesIgnoringSafeArea(.all)
        }
    }
}


