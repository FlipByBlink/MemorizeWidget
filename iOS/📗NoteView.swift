import SwiftUI

struct 📗NoteView: View {
    @EnvironmentObject var model: 📱AppModel
    @Binding private var source: 📗Note
    private var layout: Self.Layout
    @Environment(\.scenePhase) var scenePhase
    @State private var inputting: Bool = false
    @State private var inputtingNote: 📗Note = .empty
    @FocusState private var focusArea: Self.FocusArea?
    var body: some View {
        HStack {
            Group {
                if self.inputting || self.isNewNote {
                    self.inputNoteView()
                } else {
                    self.staticNoteView()
                }
            }
            .padding(.leading, 12)
            .padding(.vertical, 12)
            .animation(.default, value: self.inputting)
            if self.layout == .notesList {
                📚MenuButton(self.inputting ? self.$inputtingNote : self.$source)
            }
        }
    }
    init(_ note: Binding<📗Note>, layout: Self.Layout) {
        self._source = note; self.layout = layout
    }
}

extension 📗NoteView {
    enum Layout: Equatable {
        case notesList, widgetSheet_single, widgetSheet_multi(Int)
        var titleFont: Font {
            switch self {
                case .notesList: .title2
                case .widgetSheet_single: .largeTitle
                case .widgetSheet_multi(let ⓒount): ⓒount < 4 ? .title : .body
            }
        }
        var commentFont: Font {
            switch self {
                case .notesList: .body
                case .widgetSheet_single: .title
                case .widgetSheet_multi(let ⓒount): ⓒount < 4 ? .title3 : .subheadline
            }
        }
    }
}

private extension 📗NoteView {
    private enum FocusArea {
        case title, comment
    }
    private var thin: Bool {
        !self.model.randomMode
        && (self.source != self.model.notes.first)
    }
    private var isNewNote: Bool {
        self.source.id == self.model.createdNewNoteID
    }
    private func inputNoteView() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            TextField("+ title", text: self.$inputtingNote.title)
                .focused(self.$focusArea, equals: .title)
                .font(self.layout.titleFont.weight(.semibold))
            TextField("+ comment", text: self.$inputtingNote.comment)
                .focused(self.$focusArea, equals: .comment)
                .font(self.layout.commentFont.weight(.light))
                .foregroundStyle(.secondary)
                .opacity(0.8)
        }
        .onSubmit { UISelectionFeedbackGenerator().selectionChanged() }
        .onChange(of: self.focusArea, perform: self.handleUnfocus)
        .onChange(of: self.scenePhase, perform: self.sceneHandling(_:))
        .onAppear {
            if self.isNewNote {
                self.startToInput(.title)
                self.model.createdNewNoteID = nil
            }
        }
    }
    private func staticNoteView() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Group {
                    self.source.title.isEmpty ? Text("+ title") : Text(self.source.title)
                }
                .font(self.layout.titleFont.weight(.semibold))
                .foregroundStyle(self.source.title.isEmpty ? .secondary : .primary)
                .opacity(self.thin ? 0.4 : 1)
                .animation(.default.speed(1.5), value: self.thin)
                .padding(.bottom, 1)
                .onTapGesture { self.startToInput(.title) }
                Group {
                    self.source.comment.isEmpty ? Text("no comment") : Text(self.source.comment)
                }
                .font(self.layout.commentFont.weight(.light))
                .foregroundStyle(self.source.comment.isEmpty ? .tertiary : .secondary)
                .padding(.bottom, 1)
                .onTapGesture { self.startToInput(.comment) }
            }
            Spacer(minLength: 0)
        }
    }
    private func startToInput(_ ⓐrea: Self.FocusArea) {
        self.inputtingNote = self.source
        withAnimation { self.inputting = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            withAnimation { self.focusArea = ⓐrea }
        }
    }
    private func handleUnfocus(_ ⓕocus: Self.FocusArea?) {
        if ⓕocus == nil {
            if self.inputtingNote.isEmpty {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.66) {
                    self.model.removeNote(self.source, feedback: false)
                }
            } else {
                self.model.apply(self.inputtingNote, target: self.source)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    withAnimation { self.inputting = false }
                }
            }
        }
    }
    private func sceneHandling(_ ⓟhase: ScenePhase) {
        if ⓟhase == .background, self.focusArea != nil {
            self.focusArea = nil
        }
    }
}
