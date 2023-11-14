import SwiftUI

struct 🎛️OptionTab: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("🎛️FontSizeOptionMenu") {
                    🎛️FontSizeOptionMenu()
                }
                🎛️MultiNotesOnWidgetOption()
                🎛️CommentOnWidgetOption()
                🔍CustomizeSearchSheetButton()
            }
            .navigationTitle("Option")
        }
    }
}
