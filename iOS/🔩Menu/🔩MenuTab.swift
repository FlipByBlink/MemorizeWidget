import SwiftUI

struct 🔩MenuTab: View {
    var body: some View {
        List {
            🔩MultiNotesOnWidgetOption()
            🔩CommentOnWidgetOption()
        }
        .navigationTitle("Option")
    }
}
