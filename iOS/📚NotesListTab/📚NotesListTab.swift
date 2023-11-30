import SwiftUI

struct 📚NotesListTab: View {
    @EnvironmentObject var model: 📱AppModel
    @FocusedValue(\.editingNote) var editingNote
    var body: some View {
        NavigationStack {
            ScrollViewReader { ⓟroxy in
                List {
                    Self.RandomModeSection()
                    Section {
                        self.newNoteOnTopButton()
                        ForEach(self.$model.notes) {
                            📗NoteView(source: $0,
                                       titleFont: .title2,
                                       commentFont: .body,
                                       placement: .notesList)
                            .id($0.id)
                        }
                        .onMove { self.model.moveNoteForDynamicView($0, $1) }
                        .onDelete(perform: self.onDeleteAction)
                    } footer: {
                        self.notesCountTextOnFooter()
                    }
                    .animation(.default, value: self.model.notes)
                }
                .navigationBarTitleDisplayMode(.inline)
                .scrollDismissesKeyboard(.interactively)
                .onChange(of: self.self.model.createdNewNoteID) { ⓟroxy.scrollTo($0) }
                .onOpenURL { self.model.scrollTopByNewNoteShortcut($0, ⓟroxy) }
                .animation(.default, value: self.model.notes)
                .toolbar {
                    switch UIDevice.current.userInterfaceIdiom {
                        case .phone:
                            📚NotesMenuButton(placement: .topBarLeading)
                        case .pad:
                            ToolbarItem(placement: .bottomBar) {
                                📥NotesImportSheetButton()
                            }
                            self.notesCountTextOnBottomBar()
                            📚NotesMenuButton(placement: .bottomBar)
                        default:
                            ToolbarItem { EmptyView() }
                    }
                    self.editButton(placement: .topBarTrailing)
                }
            }
        }
    }
}

private extension 📚NotesListTab {
    private var onDeleteAction: Optional<(IndexSet) -> Void> {
        if self.editingNote == nil {
            self.model.deleteNotesForDynamicView
        } else {
            nil
        }
    }
    private struct RandomModeSection: View {
        @Environment(\.horizontalSizeClass) var horizontalSizeClass
        var body: some View {
            Section {
                🎛️RandomModeToggle()
                    .padding(.vertical, 8)
            } footer: {
                if UIDevice.current.userInterfaceIdiom == .phone
                    || self.horizontalSizeClass == .compact {
                    🎛️RandomModeToggle.Caption()
                }
            }
        }
    }
    private func newNoteOnTopButton() -> some View {
        Button(action: self.model.addNewNoteOnTop) {
            Label("New note", systemImage: "plus")
                .font(.title3.weight(.semibold))
                .padding(.vertical, 7)
        }
        .id("NewNoteButton")
        .modifier(📚DisableInEditMode())
    }
    private func notesCountTextOnFooter() -> some View {
        Group {
            if UIDevice.current.userInterfaceIdiom == .phone
                && self.model.notes.count > 7 {
                Text("Notes count: \(self.model.notes.count)")
            }
        }
    }
    private func notesCountTextOnBottomBar() -> some ToolbarContent {
        ToolbarItem(placement: .status) {
            Text("Notes count: \(self.model.notes.count)")
                .font(.caption.weight(.light))
                .foregroundStyle(.secondary)
        }
    }
    private func editButton(placement: ToolbarItemPlacement) -> some ToolbarContent {
        ToolbarItem(placement: placement) {
            EditButton()
                .disabled(self.model.notes.isEmpty)
        }
    }
}
