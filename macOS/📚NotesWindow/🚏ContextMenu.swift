import SwiftUI

struct 🚏ContextMenu: View {
    @EnvironmentObject var model: 📱AppModel
    private var ids: Set<UUID>
    private var targetNotes: Set<📗Note> {
        .init(self.model.notes.filter { self.ids.contains($0.id) })
    }
    var body: some View {
        📘DictionaryButton(notes: self.targetNotes)
        🔍SearchButton(notes: self.targetNotes)
        Divider()
        🛫MoveTopButton(notes: self.targetNotes)
        🛬MoveEndButton(notes: self.targetNotes)
        Divider()
        👆InsertAboveButton(notes: self.targetNotes)
        👇InsertBelowButton(notes: self.targetNotes)
    }
    init(_ ids: Set<UUID>) {
        self.ids = ids
    }
}
