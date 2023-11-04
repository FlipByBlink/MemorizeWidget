import SwiftUI
import WidgetKit

struct 🔩MultiNotesOnWidgetOption: View {
    @AppStorage("multiNotes", store: .ⓐppGroup) var value: Bool = false
    var body: some View {
        Section {
            Toggle(isOn: self.$value) {
                Label("Show multi notes on widget", systemImage: "doc.on.doc")
                    .padding(.vertical, 8)
            }
            .onChange(of: self.value) { _ in
                WidgetCenter.shared.reloadAllTimelines()
            }
            VStack(spacing: 12) {
                🔩BeforeAfterImages("home_multiNotes_before",
                                    "home_multiNotes_after")
                if UIDevice.current.userInterfaceIdiom == .phone {
                    🔩BeforeAfterImages("lockscreen_multiNotes_before",
                                        "lockscreen_multiNotes_after")
                }
            }
            .padding()
        } header: {
            Text("Option")
        }
    }
}
