import SwiftUI

enum 📥Error: Error {
    case dataSizeLimitExceeded, others(String)
    func messageText() -> some View {
        switch self {
            case .dataSizeLimitExceeded:
                Text("Total notes data over 800kB. Please decrease notes.")
            case .others(let ⓛocalizedDescription):
                Text(ⓛocalizedDescription)
        }
    }
}
