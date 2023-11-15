import SwiftUI

struct 🎛️OptionTab: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("🎛️FontSizeOptionMenu") { 🎛️FontSizeOptionMenu() } //TODO: ちゃんと実装
                🎛️MultiNotesOnWidgetOption()
                🎛️CommentOnWidgetOption()
                🔍CustomizeSearchSheetButton()
            }
            .navigationTitle("Option")
        }
    }
}
