import SwiftUI

struct 📥SeparatorPicker: View {
    @AppStorage("separator", store: .ⓐppGroup) var separator: 📚TextConvert.Separator = .tab
    var body: some View {
        Picker(selection: self.$separator) {
            Text("Tab ␣ ")
                .tag(📚TextConvert.Separator.tab)
                .accessibilityLabel("Tab")
            Text("Comma , ")
                .tag(📚TextConvert.Separator.comma)
                .accessibilityLabel("Comma")
            Text("(Title only)")
                .tag(📚TextConvert.Separator.titleOnly)
                .accessibilityLabel("Title only")
        } label: {
            Label("Separator", systemImage: "arrowtriangle.left.and.line.vertical.and.arrowtriangle.right")
        }
    }
}
