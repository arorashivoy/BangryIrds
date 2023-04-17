import SwiftUI

struct ContentView: View {
    var body: some View {
        // TODO: add a warning that the focus entity should be stable
        ZStack{
            RealityKitView()
                .edgesIgnoringSafeArea(.all)
        }
    }
}


