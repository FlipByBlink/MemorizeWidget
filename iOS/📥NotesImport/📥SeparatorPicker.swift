import SwiftUI

struct 📥SeparatorPicker: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        Picker(selection: self.$model.separator) {
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
