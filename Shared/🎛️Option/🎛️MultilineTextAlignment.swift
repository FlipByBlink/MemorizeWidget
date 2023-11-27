import SwiftUI

enum 🎛️MultilineTextAlignment: String {
    case leading, center, trailing
}

extension 🎛️MultilineTextAlignment: CaseIterable, Identifiable {
    var id: Self { self }
    static func loadUserDeaults() -> Self {
        if let ⓢtring = 💾UserDefaults.appGroup.string(forKey: 🎛️Key.multilineTextAlignment),
           let ⓥalue = Self(rawValue: ⓢtring) {
            ⓥalue
        } else {
            .center
        }
    }
    var localizedTitle: LocalizedStringKey {
        switch self {
            case .leading: "leading"
            case .center: "center"
            case .trailing: "trailing"
        }
    }
    var iconName: String {
        switch self {
            case .leading: "text.justify.leading"
            case .center: "text.aligncenter"
            case .trailing: "text.justify.trailing"
        }
    }
    var value: TextAlignment {
        switch self {
            case .leading: .leading
            case .center: .center
            case .trailing: .trailing
        }
    }
}
