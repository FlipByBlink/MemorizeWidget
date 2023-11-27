import SwiftUI

struct 📚SubButtons: View {
    @EnvironmentObject var appModel: 📱AppModel
    @StateObject var searchModel: 🔍SearchModel = .init()
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(\.editMode) var editMode
    @Environment(\.openURL) var openURL
    @FocusedValue(\.editingNote) var editingNote
    @Binding private var note: 📗Note
    var body: some View {
        HStack {
            if Self.isIPad && !self.editing {
                self.dictionaryButton()
                self.searchButton(self.note.title)
            }
            Menu {
                if !Self.isIPad {
                    self.dictionaryButton()
                    self.searchButton(self.note.title)
                }
                self.insertNewNoteBelowButton()
                self.moveButtons()
                Section {
                    🚮DeleteNoteButton(self.note)
                        .disabled(self.editingNote != nil)
                }
            } label: {
                Label("Menu", systemImage: "ellipsis.circle")
                    .padding(8)
            }
            .hoverEffect()
            .modifier(🩹Workaround.CloseMenePopup())
        }
        .padding(4)
        .foregroundStyle(.secondary)
        .labelStyle(.iconOnly)
        .buttonStyle(.plain)
        .disabled(self.editing)
        .font(self.dynamicTypeSize > .accessibility1 ? .system(size: 24) : .body)
        .modifier(🔍FailureAlert(self.searchModel))
    }
    init(_ note: Binding<📗Note>) {
        self._note = note
    }
}

private extension 📚SubButtons {
    private static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    private var editing: Bool {
        self.editMode?.wrappedValue.isEditing == true
    }
    private func dictionaryButton() -> some View {
        Button {
            self.appModel.presentSheet(.dictionary(.init(term: self.note.title)))
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
                .padding(8)
        }
        .hoverEffect()
    }
    private func searchButton(_ ⓠuery: String) -> some View {
        Button {
            let ⓤrl = self.searchModel.generateURL(ⓠuery)
            if self.searchModel.openURLInOtherApp {
                self.openURL(ⓤrl) {
                    if $0 == false { self.searchModel.alertOpenURLFailure = true }
                }
            } else {
                self.appModel.presentSheet(.search(ⓤrl))
            }
        } label: {
            Label("Search", systemImage: "magnifyingglass")
                .padding(8)
        }
        .disabled(!self.searchModel.ableInAppSearch)
        .hoverEffect()
    }
    private func insertNewNoteBelowButton() -> some View {
        Button {
            self.appModel.addNewNoteBelow(self.note)
        } label: {
            Label("New note", systemImage: "text.append")
        }
    }
    private func moveButtons() -> some View {
        Section {
            Button {
                self.appModel.moveTop(self.note)
            } label: {
                Label("Move top", systemImage: "arrow.up.to.line")
            }
            .disabled(self.appModel.notes.first == self.note)
            Button {
                self.appModel.moveEnd(self.note)
            } label: {
                Label("Move end", systemImage: "arrow.down.to.line")
            }
            .disabled(self.appModel.notes.last == self.note)
        }
    }
}
