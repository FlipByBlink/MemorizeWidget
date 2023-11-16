import SwiftUI

struct 🎛️MultiNotesOnWidgetOption: View {
    var body: some View {
        Section {
            🎛️ViewComponent.MultiNotesToggle()
                .padding(.vertical, 8)
            VStack(spacing: 16) {
                🎛️BeforeAfterImages(.systemFamilyDefault, .systemFamilyMultiNotes)
                if Self.showAccessoryFamilyPreview {
                    🎛️BeforeAfterImages(.accessoryFamilyDefault, .accessoryFamilyMultiNotes)
                }
            }
            .padding()
        }
    }
}

private extension 🎛️MultiNotesOnWidgetOption {
    private static var showAccessoryFamilyPreview: Bool {
        if #available(iOS 17.0, *) {
            true
        } else {
            if UIDevice.current.userInterfaceIdiom == .phone {
                true
            } else {
                false
            }
        }
    }
}
