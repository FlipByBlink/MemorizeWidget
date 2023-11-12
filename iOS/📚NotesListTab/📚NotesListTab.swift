import SwiftUI
import WidgetKit

struct 📚NotesListTab: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        ScrollViewReader { ⓢcrollViewProxy in
            List {
                self.randomModeSection()
                Section {
                    Self.NewNoteOnTopButton()
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
                    self.notesCountTextOnFooter()
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
                        Self.MenuButton(placement: .topBarLeading)
                        self.editButton(placement: .topBarTrailing)
                    case .pad:
                        Self.MenuButton(placement: .bottomBar)
                        self.notesCountTextOnBottomBar()
                        self.editButton(placement: .bottomBar)
                    default:
                        ToolbarItem { EmptyView() }
                }
            }
            //.toolbar(UIDevice.current.userInterfaceIdiom == .pad ? .hidden : .visible,
            //         for: .navigationBar)
            //sidebarを非表示にすると再度sidebarを表示することが難しくなってしまう
        }
    }
}

private extension 📚NotesListTab {
    private func randomModeSection() -> some View {
        Section {
            🎛️RandomModeToggle()
                .padding(.vertical, 8)
        } footer: {
            🎛️RandomModeToggle.Caption()
        }
    }
    private struct NewNoteOnTopButton: View {
        @EnvironmentObject var model: 📱AppModel
        @Environment(\.editMode) var editMode
        var body: some View {
            Button(action: self.model.addNewNoteOnTop) {
                Label("New note", systemImage: "plus")
                    .font(.title3.weight(.semibold))
                    .padding(.vertical, 7)
            }
            .id("NewNoteButton")
            .disabled(self.editMode?.wrappedValue == .active)
        }
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
    private struct MenuButton: ToolbarContent {
        @EnvironmentObject var model: 📱AppModel
        @Environment(\.editMode) var editMode
        let placement: ToolbarItemPlacement
        var body: some ToolbarContent {
            ToolbarItem(placement: self.placement) {
                Menu {
                    Button {
                        self.model.presentSheet(.notesImport)
                    } label: {
                        Label("Import notes", systemImage: "tray.and.arrow.down")
                    }
                    Menu {
                        Button {
                            self.model.presentSheet(.notesExport)
                        } label: {
                            Label("Export notes", systemImage: "tray.and.arrow.up")
                        }
                        .disabled(self.model.notes.isEmpty)
                        Divider()
                        Button {
                            self.model.presentSheet(.customizeSearch)
                        } label: {
                            Label("Customize search", systemImage: "magnifyingglass")
                        }
                        Divider()
                        🚮DeleteAllNotesButton()
                    } label: {
                        Label("More", systemImage: "ellipsis")
                    }
                } label: {
                    Label("Menu", systemImage: "wand.and.rays")
                }
                .disabled(self.editMode?.wrappedValue == .active)
            }
        }
    }
}
