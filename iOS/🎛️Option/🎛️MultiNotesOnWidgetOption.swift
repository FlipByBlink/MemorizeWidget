import SwiftUI

struct 🎛️MultiNotesOnWidgetOption: View {
    var body: some View {
        Section {
            🎛️OptionViewComponent.MultiNotesToggle()
                .padding(.vertical, 8)
            VStack(spacing: 12) {
                🎛️BeforeAfterImages("home_multiNotes_before",
                                    "home_multiNotes_after")
                if UIDevice.current.userInterfaceIdiom == .phone {
                    🎛️BeforeAfterImages("lockscreen_multiNotes_before",
                                        "lockscreen_multiNotes_after")
                }
            }
            .padding()
        }
    }
}
