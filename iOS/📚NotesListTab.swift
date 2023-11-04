import SwiftUI
import WidgetKit

struct 📚NotesListTab: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            ScrollViewReader { ⓢcrollViewProxy in
                List {
                    Self.RandomModeSection()
                    Section {
                        Self.NewNoteOnTopButton()
                        ForEach(self.$model.notes) { ⓝote in
                            📗NoteView(ⓝote, layout: .notesList)
                                .id(ⓝote.id)
                        }
                        .onDelete { self.model.deleteNote($0) }
                        .onMove { self.model.moveNote($0, $1) }
                    } footer: {
                        Text("Notes count: \(self.model.notes.count)")
                            .opacity(self.model.notes.count < 6  ? 0 : 1)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .onChange(of: self.self.model.createdNewNoteID) { ⓢcrollViewProxy.scrollTo($0) }
                .onOpenURL { self.handleNewNoteShortcut($0, ⓢcrollViewProxy) }
                .animation(.default, value: self.model.notes)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                            .disabled(self.model.notes.isEmpty)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        self.importNotesButton()
                    }
                }
            }
        }
    }
}

private extension 📚NotesListTab {
    private func handleNewNoteShortcut(_ ⓤrl: URL, _ ⓢcrollViewProxy: ScrollViewProxy) {
        if case .newNoteShortcut = 🪧WidgetInfo.load(ⓤrl) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                ⓢcrollViewProxy.scrollTo("NewNoteButton")
                self.model.addNewNoteOnTop()
            }
        }
    }
    private struct RandomModeSection: View {
        @EnvironmentObject var model: 📱AppModel
        var body: some View {
            Section {
                Toggle(isOn: self.$model.randomMode) {
                    Label("Random mode", systemImage: "shuffle")
                        .padding(.vertical, 8)
                }
                .onChange(of: self.model.randomMode) { _ in
                    WidgetCenter.shared.reloadAllTimelines()
                }
            } footer: {
                Text("Change the note per 5 minutes.")
            }
        }
    }
    private struct NewNoteOnTopButton: View {
        @EnvironmentObject var model: 📱AppModel
        var body: some View {
            Button(action: self.model.addNewNoteOnTop) {
                Label("New note", systemImage: "plus")
                    .font(.title3.weight(.semibold))
                    .padding(.vertical, 7)
            }
            .id("NewNoteButton")
        }
    }
    private func importNotesButton() -> some View {
        Button {
            UISelectionFeedbackGenerator().selectionChanged()
            self.model.showNotesImportSheet.toggle()
        } label: {
            Label("Import notes", systemImage: "tray.and.arrow.down")
        }
    }
}
