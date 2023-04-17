import SwiftUI
import Combine
import UIKit

final class ModelData: ObservableObject {
    static let shared = ModelData()
    
    @Published var currLevel: Int = 0
    let maxLevel: Int = 5
    
    @Published var tutorial: Bool = false
    
    @Published var play: Bool = false
}
