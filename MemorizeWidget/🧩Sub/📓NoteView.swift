import SwiftUI

struct 📓NoteView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Binding private var ⓝote: 📗Note
    private var ⓛayout: 🄻ayout
    @State private var 🚩inputting: Bool = false
    @State private var ⓘnputtingNote: 📗Note = .empty
    @FocusState private var 🔍focusState: 🄵ocusArea?
    private var 🎨thin: Bool {
        !📱.🪧widgetState.showSheet
        && !📱.🚩randomMode
        && 📱.📚notes.first != self.ⓝote
    }
    private var ⓘsNewNote: Bool { self.ⓝote.id == 📱.🆕newNoteID }
    var body: some View {
        HStack {
            Group {
                if self.🚩inputting || self.ⓘsNewNote {
                    self.ⓘnputNoteView()
                } else {
                    self.ⓢtaticNoteView()
                }
            }
            .padding(.leading, 12)
            .padding(.vertical, 12)
            .animation(.default, value: self.🚩inputting)
            if self.ⓛayout == .notesList {
                🎛️NoteMenuButton(self.🚩inputting ? self.$ⓘnputtingNote : self.$ⓝote)
            }
        }
    }
    private func ⓘnputNoteView() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            TextField("+ title", text: self.$ⓘnputtingNote.title)
                .focused(self.$🔍focusState, equals: .title)
                .font(self.ⓛayout.titleFont.weight(.semibold))
            TextField("+ comment", text: self.$ⓘnputtingNote.comment)
                .focused(self.$🔍focusState, equals: .comment)
                .font(self.ⓛayout.commentFont.weight(.light))
                .foregroundStyle(.secondary)
                .opacity(0.8)
        }
        .onSubmit { UISelectionFeedbackGenerator().selectionChanged() }
        .onChange(of: self.🔍focusState, perform: self.ⓗandleUnfocus)
        .onAppear {
            if self.ⓘsNewNote {
                self.ⓢtartToInput(.title)
                self.📱.🆕newNoteID = nil
            }
        }
    }
    private func ⓢtaticNoteView() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Group {
                    self.ⓝote.title.isEmpty ? Text("+ title") : Text(self.ⓝote.title)
                }
                .font(self.ⓛayout.titleFont.weight(.semibold))
                .foregroundStyle(self.ⓝote.title.isEmpty ? .secondary : .primary)
                .padding(.bottom, 1)
                .onTapGesture { self.ⓢtartToInput(.title) }
                Group {
                    self.ⓝote.comment.isEmpty ? Text("no comment") : Text(self.ⓝote.comment)
                }
                .font(self.ⓛayout.commentFont.weight(.light))
                .foregroundStyle(self.ⓝote.comment.isEmpty ? .tertiary : .secondary)
                .padding(.bottom, 1)
                .onTapGesture { self.ⓢtartToInput(.comment) }
            }
            .opacity(self.🎨thin ? 0.4 : 1)
            .animation(.default.speed(1.5), value: self.🎨thin)
            Spacer(minLength: 0)
        }
    }
    private func ⓢtartToInput(_ ⓐrea: 🄵ocusArea) {
        self.ⓘnputtingNote = self.ⓝote
        withAnimation { self.🚩inputting = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            withAnimation { self.🔍focusState = ⓐrea }
        }
    }
    private func ⓗandleUnfocus(_ ⓕocus: 🄵ocusArea?) {
        if ⓕocus == nil {
            if self.ⓘnputtingNote.isEmpty {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.66) {
                    📱.removeNote(self.ⓝote, feedback: false)
                }
            } else {
                📱.apply(self.ⓘnputtingNote, target: self.ⓝote)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    withAnimation { self.🚩inputting = false }
                }
            }
        }
    }
    init(_ note: Binding<📗Note>, layout: 🄻ayout) {
        self._ⓝote = note; self.ⓛayout = layout
    }
}

enum 🄻ayout {
    case notesList, widgetSheet_single, widgetSheet_multi
    var titleFont: Font {
        switch self {
            case .notesList: return .title2
            case .widgetSheet_single: return .largeTitle
            case .widgetSheet_multi: return .title
        }
    }
    var commentFont: Font {
        switch self {
            case .notesList: return .body
            case .widgetSheet_single: return .title
            case .widgetSheet_multi: return .title3
        }
    }
}

enum 🄵ocusArea {
    case title, comment
}
