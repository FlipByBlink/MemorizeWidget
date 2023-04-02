import SwiftUI

struct 📓NoteView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Binding private var ⓝote: 📗Note
    @State private var 🚩inputting: Bool = false
    @FocusState private var 🔍focusState: 🄵ocusArea?
    private var 🎨thin: Bool { !📱.🚩randomMode && (📱.📚notes.first != self.ⓝote) }
    var body: some View {
        Group {
            if self.🚩inputting {
                self.ⓘnputNoteView()
            } else {
                self.ⓢtaticNoteView()
            }
        }
        .opacity(self.🎨thin ? 0.5 : 1)
        .padding(.leading, 12)
        .padding(.vertical, 12)
        .onChange(of: self.🔍focusState, perform: self.ⓗandleUnfocus)
        .onAppear(perform: self.ⓢetFocusForEmptyNote)
        .animation(.default, value: self.🚩inputting)
    }
    private func ⓘnputNoteView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("+ title", text: self.$ⓝote.title)
                .focused(self.$🔍focusState, equals: .title)
                .font(.title2.weight(.semibold))
            TextField("+ comment", text: self.$ⓝote.comment)
                .focused(self.$🔍focusState, equals: .comment)
                .font(.body.weight(.light))
                .foregroundStyle(.secondary)
                .opacity(0.8)
        }
        .onSubmit { UISelectionFeedbackGenerator().selectionChanged() }
    }
    private func ⓢtaticNoteView() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(self.ⓝote.title.isEmpty ? "no title" : self.ⓝote.title)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(self.ⓝote.title.isEmpty ? .secondary : .primary)
                    .padding(.bottom, 1)
                    .onTapGesture { self.ⓢtartToInput(.title) }
                Text(self.ⓝote.comment.isEmpty ? "no comment" : self.ⓝote.comment)
                    .font(.body.weight(.light))
                    .foregroundStyle(self.ⓝote.comment.isEmpty ? .tertiary : .secondary)
                    .padding(.bottom, 1)
                    .onTapGesture { self.ⓢtartToInput(.comment) }
            }
            Spacer()
        }
    }
    private func ⓢtartToInput(_ ⓐrea: 🄵ocusArea) {
        withAnimation { self.🚩inputting = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            withAnimation { self.🔍focusState = ⓐrea }
        }
    }
    private func ⓗandleUnfocus(_ ⓕocus: 🄵ocusArea?) {
        if ⓕocus == nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation { self.🚩inputting = false }
                if self.ⓝote.isEmpty {
                    self.📱.📚notes.removeAll { $0 == self.ⓝote }
                }
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
}

enum 🄵ocusArea {
    case title, comment
}

struct 🗑DeleteNoteButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    private var ⓝote: 📗Note
    var body: some View {
        Button(role: .destructive) {
            withAnimation {
                📱.📚notes.removeAll { $0 == self.ⓝote }
            }
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
    init(_ ⓝote: 📗Note) {
        self.ⓝote = ⓝote
    }
}
