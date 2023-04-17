import SwiftUI

@main
struct MyApp: App {
    @StateObject private var modelData = ModelData.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}


/// Keys for @AppStorage wrapper
enum StorageString: String {
    case currLevel
    case tutorialDone
}
