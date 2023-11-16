import SwiftUI

enum 📥Error: Error {
    case dataSizeLimitExceeded
    case others(String)
}

extension 📥Error {
    func messageText() -> some View {
        switch self {
            case .dataSizeLimitExceeded:
                Text("Total notes data over 800kB. Please decrease notes.")
            case .others(let ⓛocalizedDescription):
                Text(ⓛocalizedDescription)
        }
    }
}
