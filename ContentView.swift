import SwiftUI

struct ContentView: View {
    var body: some View {
        // TODO: Add worning that camera should be head on when placing the level
        ZStack{
            RealityKitView()
                .edgesIgnoringSafeArea(.all)
        }
    }
}


