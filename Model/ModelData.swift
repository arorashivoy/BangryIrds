import SwiftUI
import Combine
import UIKit

final class ModelData: ObservableObject {
    static let shared = ModelData()
    
    @AppStorage(StorageString.currLevel.rawValue)
    var currLevel: Int = 0 {
        willSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    let maxLevel: Int = 5
    
    @Published var tutorial: Bool = false
    
    @Published var play: Bool = false
}
