import SwiftUI
import WidgetKit

struct 📚NotesListTab: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            ScrollViewReader { ⓢcrollViewProxy in
                List {
                    self.randomModeSection()
                    Section {
                        self.newNoteOnTopButton()
                        ForEach(self.$model.notes) {
                            📗NoteView(source: $0,
                                       titleFont: .title2,
                                       commentFont: .body,
                                       placement: .notesList)
                            .id($0.id)
                        }
                        .onDelete { self.model.deleteNoteOnNotesList($0) }
                        .onMove { self.model.moveNote($0, $1) }
                    } footer: {
                        🔢NotesCountText.ListFooter()
                    }
                    .animation(.default, value: self.model.notes)
                }
                .navigationBarTitleDisplayMode(.inline)
                .scrollDismissesKeyboard(.interactively)
                .onChange(of: self.self.model.createdNewNoteID) { ⓢcrollViewProxy.scrollTo($0) }
                .onOpenURL { self.model.scrollTopByNewNoteShortcut($0, ⓢcrollViewProxy) }
                .animation(.default, value: self.model.notes)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                            .disabled(self.model.notes.isEmpty)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        self.presentNotesImportSheetButton()
                    }
                }
            }
        }
    }
}

private extension 📚NotesListTab {
    private func randomModeSection() -> some View {
        Section {
            🔀RandomModeToggle()
                .padding(.vertical, 8)
        } footer: {
            🔀RandomModeToggle.Caption()
        }
    }
    private func newNoteOnTopButton() -> some View {
        Button(action: self.model.addNewNoteOnTop) {
            Label("New note", systemImage: "plus")
                .font(.title3.weight(.semibold))
                .padding(.vertical, 7)
        }
        .id("NewNoteButton")
    }
    private func presentNotesImportSheetButton() -> some View {
        Button {
            UISelectionFeedbackGenerator().selectionChanged()
            self.model.presentedSheetOnContentView = .notesImport
        } label: {
            Label("Import notes", systemImage: "tray.and.arrow.down")
        }
    }
}
