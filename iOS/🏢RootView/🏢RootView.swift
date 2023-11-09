import SwiftUI

struct 🏢RootView: View {
    var body: some View {
        switch UIDevice.current.userInterfaceIdiom {
            case .pad: 🏢IPadView()
            default: 🔖TabView()
        }
    }
}
