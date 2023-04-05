import SwiftUI

struct 📓NoteView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Binding private var ⓝote: 📗Note
    private var ⓣitleFont: Font = .title2
    private var ⓒommnetFont: Font = .body
    @State private var 🚩inputting: Bool = false
    @State private var ⓘnputtingNote: 📗Note = .empty
    @FocusState private var 🔍focusState: 🄵ocusArea?
    private var 🎨thin: Bool {
        !📱.🪧widgetState.showSheet
        && !📱.🚩randomMode
        && 📱.📚notes.first != self.ⓝote
    }
    var body: some View {
        Group {
            if self.🚩inputting {
                self.ⓘnputNoteView()
            } else {
                self.ⓢtaticNoteView()
            }
        }
        .padding(.leading, 12)
        .padding(.vertical, 12)
        .onChange(of: self.🔍focusState, perform: self.ⓗandleUnfocus)
        .onAppear(perform: self.ⓢetFocusForEmptyNote)
        .animation(.default, value: self.🚩inputting)
    }
    private func ⓘnputNoteView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("+ title", text: self.$ⓘnputtingNote.title)
                .focused(self.$🔍focusState, equals: .title)
                .font(self.ⓣitleFont.weight(.semibold))
            TextField("+ comment", text: self.$ⓘnputtingNote.comment)
                .focused(self.$🔍focusState, equals: .comment)
                .font(self.ⓒommnetFont.weight(.light))
                .foregroundStyle(.secondary)
                .opacity(0.8)
        }
        .onSubmit { UISelectionFeedbackGenerator().selectionChanged() }
    }
    private func ⓢtaticNoteView() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Group {
                    self.ⓝote.title.isEmpty ? Text("+ title") : Text(self.ⓝote.title)
                }
                .font(self.ⓣitleFont.weight(.semibold))
                .foregroundStyle(self.ⓝote.title.isEmpty ? .secondary : .primary)
                .padding(.bottom, 1)
                .onTapGesture { self.ⓢtartToInput(.title) }
                Group {
                    self.ⓝote.comment.isEmpty ? Text("no comment") : Text(self.ⓝote.comment)
                }
                .font(self.ⓒommnetFont.weight(.light))
                .foregroundStyle(self.ⓝote.comment.isEmpty ? .tertiary : .secondary)
                .padding(.bottom, 1)
                .onTapGesture { self.ⓢtartToInput(.comment) }
            }
            .opacity(self.🎨thin ? 0.4 : 1)
            .animation(.default.speed(1.5), value: self.🎨thin)
            Spacer()
        }
    }
    private func ⓢtartToInput(_ ⓐrea: 🄵ocusArea) {
        self.ⓘnputtingNote = self.ⓝote
        withAnimation { self.🚩inputting = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation { self.🔍focusState = ⓐrea }
        }
    }
    private func ⓗandleUnfocus(_ ⓕocus: 🄵ocusArea?) {
        if ⓕocus == nil {
            self.ⓝote = self.ⓘnputtingNote
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation { self.🚩inputting = false }
            }
        }
    }
    private func ⓢetFocusForEmptyNote() {
        if self.ⓝote.isEmpty {
            self.ⓢtartToInput(.title)
        }
    }
    init(_ note: Binding<📗Note>) {
        self._ⓝote = note
    }
    init(_ note: Binding<📗Note>, titleFont: Font, commentFont: Font) {
        self._ⓝote = note
        self.ⓣitleFont = titleFont
        self.ⓒommnetFont = commentFont
    }
}

enum 🄵ocusArea {
    case title, comment
}
