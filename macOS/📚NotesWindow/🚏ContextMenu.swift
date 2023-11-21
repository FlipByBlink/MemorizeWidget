import SwiftUI

struct 🚏ContextMenu: View {
    @EnvironmentObject var model: 📱AppModel
    private var ids: Set<UUID>
    private var targetNotes: Set<📗Note> {
        .init(self.model.notes.filter { self.ids.contains($0.id) })
    }
    var body: some View {
        📘DictionaryButton(self.targetNotes)
        🔍SearchButton(self.targetNotes)
        Divider()
        🛫MoveTopButton(self.targetNotes)
        🛬MoveEndButton(self.targetNotes)
        Divider()
        👆InsertAboveButton(self.targetNotes)
        👇InsertBelowButton(self.targetNotes)
    }
    init(_ ids: Set<UUID>) {
        self.ids = ids
    }
}
