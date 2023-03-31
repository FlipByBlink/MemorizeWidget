import SwiftUI
import WidgetKit

struct 📚NotesListTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationView {
            ScrollViewReader { 🚡 in
                List {
                    self.🚩randomModeSection()
                    Section {
                        self.🆕newNoteButton()
                            .id("NewNoteButton")
                            .onOpenURL {
                                if $0.description == "NewNoteShortcut" {
                                    🚡.scrollTo("NewNoteButton")
                                }
                            }
                        ForEach($📱.📚notes) {
                            📓NoteRow($0, .onListTab)
                        }
                        .onDelete { 📱.📚notes.remove(atOffsets: $0) }
                        .onMove { 📱.📚notes.move(fromOffsets: $0, toOffset: $1) }
                    } footer: {
                        Text("Notes count: \(📱.📚notes.count.description)")
                            .opacity(📱.📚notes.count < 6  ? 0 : 1)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .animation(.default, value: 📱.📚notes)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                            .disabled(📱.📚notes.isEmpty)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            UISelectionFeedbackGenerator().selectionChanged()
                            📱.🚩showNotesImportSheet.toggle()
                        } label: {
                            Label("Import notes", systemImage: "tray.and.arrow.down")
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    private func 🚩randomModeSection() -> some View {
        Section {
            Toggle(isOn: self.$📱.🚩randomMode) {
                Label("Random mode", systemImage: "shuffle")
                    .padding(.vertical, 8)
            }
            .onChange(of: 📱.🚩randomMode) { _ in
                WidgetCenter.shared.reloadAllTimelines()
            }
        } footer: {
            Text("Change the note per 5 minutes.")
        }
    }
    private func 🆕newNoteButton() -> some View {
        Button {
            📱.addNewNote()
        } label: {
            Label("New note", systemImage: "plus")
                .font(.title3.weight(.semibold))
                .padding(.vertical, 7)
        }
        .disabled(📱.📚notes.first?.isEmpty == true)
    }
}
