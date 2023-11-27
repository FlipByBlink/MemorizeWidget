import SwiftUI

struct 📗NoteView: View {
    @EnvironmentObject var model: 📱AppModel
    @Binding var source: 📗Note
    var titleFont: Font
    var commentFont: Font
    var placement: 📗Placement
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.editMode) var editMode
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
            if self.placement == .notesList {
                📚SubButtons(self.inputting ? self.$inputtingNote : self.$source)
            }
        }
    }
}

private extension 📗NoteView {
    private enum FocusArea {
        case title, comment
    }
    private var thinTitleOnNotesList: Bool {
        (self.placement == .notesList)
        && !self.model.randomMode
        && (self.source != self.model.notes.first)
    }
    private var isNewNote: Bool {
        self.source.id == self.model.createdNewNoteID
    }
    private func inputNoteView() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            TextField("+ title", text: self.$inputtingNote.title)
                .focused(self.$focusArea, equals: .title)
                .font(self.titleFont.weight(.semibold))
            TextField("+ comment", text: self.$inputtingNote.comment)
                .focused(self.$focusArea, equals: .comment)
                .font(self.commentFont.weight(.light))
                .foregroundStyle(.secondary)
                .opacity(0.8)
        }
        .focusedValue(\.editingNote, self.source)
        .submitLabel(.done)
        .onSubmit { UISelectionFeedbackGenerator().selectionChanged() }
        .onChange(of: self.focusArea, perform: self.handleUnfocus)
        .onChange(of: self.scenePhase, perform: self.sceneHandling(_:))
        .onChange(of: self.editMode?.wrappedValue == .active) {
            if $0 { self.focusArea = nil }
        }
        .onAppear {
            if self.isNewNote {
                self.startToInput(.title)
                self.model.createdNewNoteID = nil
            }
        }
    }
    private func staticNoteView() -> some View {
        VStack(spacing: 6) {
            HStack {
                Group {
                    self.source.title.isEmpty ? Text("+ title") : Text(self.source.title)
                }
                .font(self.titleFont.weight(.semibold))
                .foregroundStyle(self.source.title.isEmpty ? .secondary : .primary)
                .opacity(self.thinTitleOnNotesList ? 0.4 : 1)
                .animation(.default.speed(1.5), value: self.thinTitleOnNotesList)
                .padding(.bottom, 1)
                Spacer(minLength: 0)
            }
            .contentShape(Rectangle())
            .onTapGesture { self.startToInput(.title) }
            HStack {
                Group {
                    self.source.comment.isEmpty ? Text("no comment") : Text(self.source.comment)
                }
                .font(self.commentFont.weight(.light))
                .foregroundStyle(self.source.comment.isEmpty ? .tertiary : .secondary)
                .padding(.bottom, 1)
                Spacer(minLength: 0)
            }
            .contentShape(Rectangle())
            .onTapGesture { self.startToInput(.comment) }
        }
    }
    private func startToInput(_ ⓐrea: Self.FocusArea) {
        guard self.editMode?.wrappedValue != .active else { return }
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
                    self.model.removeNote(self.source)
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
    //private struct FocusableIOS17: ViewModifier { //deferment
    //    func body(content: Content) -> some View {
    //        if #available(iOS 17.0, *) {
    //            content
    //                .focusable()
    //        } else {
    //            content
    //        }
    //    }
    //}
}
