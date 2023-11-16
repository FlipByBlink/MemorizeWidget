import SwiftUI

struct 🎛️MultiNotesOnWidgetOption: View {
    var body: some View {
        Section {
            🎛️ViewComponent.MultiNotesToggle()
                .padding(.vertical, 8)
            VStack(spacing: 12) {
                🎛️BeforeAfterImages(.systemFamilyDefault, .systemFamilyMultiNotes)
                if UIDevice.current.userInterfaceIdiom == .phone {
//                    🎛️BeforeAfterImages("lockscreen_multiNotes_before",
//                                        "lockscreen_multiNotes_after")
                }
            }
            .padding()
        }
    }
}
