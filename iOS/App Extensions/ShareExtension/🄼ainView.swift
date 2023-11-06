import SwiftUI

struct 🄼ainView: View {
    @ObservedObject var model: 📨ShareExtensionModel
    var body: some View {
        NavigationStack {
            List {
                switch self.model.type {
                    case .textFile:
                        self.separatorPicker()
                        self.notesListView()
                    case .improperFile:
                        Label("Not text file(UTF-8).", systemImage: "exclamationmark.triangle")
                            .foregroundStyle(.secondary)
                    case .selectedText:
                        if self.model.importSelectedTextAsSingleNote {
                            TextField("No title", text: self.$model.singleNote.title)
                            TextField("No comment", text: self.$model.singleNote.comment)
                                .foregroundStyle(.secondary)
                            if self.model.singleNote.title.contains("\n") {
                                Section {
                                    Button {
                                        withAnimation {
                                            self.model.importSelectedTextAsSingleNote = false
                                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                        }
                                    } label: {
                                        ZStack {
                                            Color.clear
                                            Label("Import as some notes.", systemImage: "books.vertical")
                                                .font(.subheadline)
                                        }
                                    }
                                    .listRowBackground(Color.clear)
                                    .foregroundStyle(.secondary)
                                }
                            }
                        } else {
                            self.separatorPicker()
                            self.notesListView()
                        }
                    case .exceedDataLimitation:
                        VStack {
                            Text("⚠️ Data size limitation")
                                .font(.headline)
                            Text("Total notes data over 800kB. Please decrease notes.")
                                .font(.subheadline)
                        }
                        .padding(.vertical, 8)
                    case .none:
                        if ProcessInfo().isiOSAppOnMac {
                            Text("Selected text import is not supported on macOS.")
                        } else {
                            Text(verbatim: "🐛 Bug")
                        }
                }
            }
            .toolbar {
                ToolbarItem { self.doneButton() }
                ToolbarItem(placement: .cancellationAction) { self.closeButton() }
            }
        }
        .animation(.default, value: self.model.separator)
    }
    init(_ model: 📨ShareExtensionModel) {
        self.self.model = model
    }
}

private extension 🄼ainView {
    private func separatorPicker() -> some View {
        Section {
            Picker(selection: self.$model.separator) {
                Text("Tab ␣ ")
                    .tag(📚TextConvert.Separator.tab)
                    .accessibilityLabel("Tab")
                Text("Comma , ")
                    .tag(📚TextConvert.Separator.comma)
                    .accessibilityLabel("Comma")
                Text("(Title only)")
                    .tag(📚TextConvert.Separator.titleOnly)
                    .accessibilityLabel("Title only")
            } label: {
                Label("Separator",
                      systemImage: "arrowtriangle.left.and.line.vertical.and.arrowtriangle.right")
            }
        }
    }
    private func notesListView() -> some View {
        ForEach(self.model.convertedNotes) { ⓝote in
            VStack(alignment: .leading) {
                Text(ⓝote.title)
                Text(ⓝote.comment)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 8)
        }
    }
    private func doneButton() -> some View {
        Button {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            self.model.storeNotes()
            self.model.extensionContext?.completeRequest(returningItems: nil)
        } label: {
            Image(systemName: "checkmark")
        }
        .disabled(self.model.type == .improperFile)
        .disabled(self.model.type == .exceedDataLimitation)
    }
    private func closeButton() -> some View {
        Button {
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
            self.model.extensionContext?.completeRequest(returningItems: nil)
        } label: {
            Image(systemName: "xmark")
        }
        .tint(.red)
    }
}
