import SwiftUI

struct 🔩MenuTab: View {
    var body: some View {
        NavigationStack {
            List {
                🔩MultiNotesOnWidgetOption()
                🔩CommentOnWidgetOption()
                Section {
                    🔩CustomizeSearchLink()
                    🔩ExportNotesLink()
                }
                🔩DeleteAllNotesButton()
            }
            .navigationTitle("Menu")
        }
    }
}
