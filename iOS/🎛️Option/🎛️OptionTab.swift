import SwiftUI

struct 🎛️OptionTab: View {
    var body: some View {
        List {
            🎛️MultiNotesOnWidgetOption()
            🎛️CommentOnWidgetOption()
        }
        .navigationTitle("Option")
    }
}
