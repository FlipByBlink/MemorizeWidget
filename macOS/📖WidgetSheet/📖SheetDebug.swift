import SwiftUI

struct 📖SheetDebug: ViewModifier {
    @EnvironmentObject var model: 📱AppModel
    func body(content: Content) -> some View {
        content
#if DEBUG
            .task {
                try? await Task.sleep(for: .seconds(1))
                self.model.notes.insert(.init("Placeholder"), at: 0)
                self.model.notes.insert(.init("this is title", "This is comment. This is comment. This is comment. This is comment. This is comment."), at: 0)
                self.model.notes.insert(.init("this is title", "This is comment. This is comment. This is comment. This is comment. This is comment. This is comment. This is comment. This is comment. This is comment."), at: 0)
                self.model.notes.insert(.init("this is title", "This is comment. This is comment. This is comment. This is comment. This is comment.This is comment. This is comment. This is comment. This is comment. This is comment.This is comment. This is comment. This is comment. This is comment. This is comment.This is comment. This is comment. This is comment. This is comment. This is comment."), at: 0)
                self.model.notes.insert(.init("this is title", "This is comment. This is comment. This is comment. This is comment. This is comment.This is comment. This is comment. This is comment. This is comment. This is comment.This is comment. This is comment. This is comment. This is comment. This is comment.This is comment. This is comment. This is comment. This is comment. This is comment."), at: 0)
                self.model.saveNotes()
                self.model.presentedSheetOnContentView =
                    .widget(.notes([
                        self.model.notes[0].id,
                        self.model.notes[1].id,
                        self.model.notes[2].id,
                        self.model.notes[3].id,
                        self.model.notes[4].id,
                    ]))
            }
#endif
    }
}
