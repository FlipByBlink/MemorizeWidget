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
                        if self.model.notes.count > 7 {
                            Text("Notes count: \(self.model.notes.count)")
                        }
                    }
                    .animation(.default, value: self.model.notes)
                }
                .navigationBarTitleDisplayMode(.inline)
                .scrollDismissesKeyboard(.interactively)
                .onChange(of: self.self.model.createdNewNoteID) { ⓢcrollViewProxy.scrollTo($0) }
                .onOpenURL { self.model.scrollTopByNewNoteShortcut($0, ⓢcrollViewProxy) }
                .animation(.default, value: self.model.notes)
                .toolbar {
                    switch UIDevice.current.userInterfaceIdiom {
                        case .phone:
                            self.presentImportSheetButton(placement: .topBarLeading)
                            self.editButton(placement: .topBarTrailing)
                        case .pad:
                            self.editButton(placement: .bottomBar)
                            self.presentImportSheetButton(placement: .bottomBar)
                            self.notesCountText()
                        default:
                            ToolbarItem { EmptyView() }
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
    private func notesCountText() -> some ToolbarContent {
        ToolbarItem(placement: .status) {
            Text("Notes count: \(self.model.notes.count)")
                .font(.footnote.weight(.light))
                .foregroundStyle(.secondary)
        }
    }
    private func editButton(placement: ToolbarItemPlacement) -> some ToolbarContent {
        ToolbarItem(placement: placement) {
            EditButton()
                .disabled(self.model.notes.isEmpty)
        }
    }
    private func presentImportSheetButton(placement: ToolbarItemPlacement) -> some ToolbarContent {
        ToolbarItem(placement: placement) {
            Button {
                UISelectionFeedbackGenerator().selectionChanged()
                self.model.presentedSheetOnContentView = .notesImport
            } label: {
                Label("Import notes", systemImage: "tray.and.arrow.down")
            }
        }
    }
}
