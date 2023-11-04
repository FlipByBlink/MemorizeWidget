import SwiftUI
import WidgetKit

struct 🔩CommentOnWidgetOption: View {
    @AppStorage("ShowComment", store: .ⓐppGroup) var value: Bool = false
    var body: some View {
        Section {
            Toggle(isOn: self.$value) {
                Label("Show comment on widget", systemImage: "text.append")
                    .padding(.vertical, 8)
            }
            .onChange(of: self.value) { _ in
                WidgetCenter.shared.reloadAllTimelines()
            }
            VStack(spacing: 12) {
                🔩BeforeAfterImages("homeSmall_commentOff", "homeSmall_commentOn")
                if UIDevice.current.userInterfaceIdiom == .phone {
                    🔩BeforeAfterImages("lockscreen_commentOff", "lockscreen_commentOn")
                }
            }
            .padding()
        }
    }
}
