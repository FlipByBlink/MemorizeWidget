import SwiftUI

struct 🔍CustomizeSearchSheetButton: View {
    @EnvironmentObject var model: 📱AppModel
    var placement: Self.Placement
    var body: some View {
        Button {
            self.model.presentSheet(.customizeSearch)
        } label: {
            Label(self.placement.labelTitle,
                  systemImage: "magnifyingglass")
        }
    }
}

extension 🔍CustomizeSearchSheetButton {
    enum Placement {
        case optionTab, bottomBar
        var labelTitle: LocalizedStringKey {
            switch self {
                case .optionTab: "Customize search function"
                case .bottomBar: "Customize search"
            }
        }
    }
}
