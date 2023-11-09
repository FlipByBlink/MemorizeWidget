import SwiftUI

enum 🔢NotesCountText {
    struct ListFooter: View {
        @EnvironmentObject var model: 📱AppModel
        @Environment(\.horizontalSizeClass) var horizontalSizeClass
        var body: some View {
            if self.horizontalSizeClass == .compact,
               self.model.notes.count > 6 {
                Text("Notes count: \(self.model.notes.count)")
            }
        }
    }
    struct BottomToolbar: ViewModifier {
        @EnvironmentObject var model: 📱AppModel
        func body(content: Content) -> some View {
            content
                .toolbar {
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        ToolbarItem(placement: .bottomBar) {
                            Text("Notes count: \(self.model.notes.count)")
                                .font(.footnote.weight(.light))
                                .foregroundStyle(.secondary)
                        }
                    }
                }
        }
    }
}
