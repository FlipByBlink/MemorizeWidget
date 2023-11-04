import SwiftUI

struct 🆕NewNoteShortcut: ViewModifier {
    @EnvironmentObject var model: 📱AppModel
    @State private var showSheet: Bool = false
    @State private var title: String = ""
    @State private var comment: String = ""
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: self.$showSheet) {
                List {
                    TextField("Title", text: self.$title)
                        .font(.headline)
                    TextField("Comment", text: self.$comment)
                        .font(.subheadline)
                        .opacity(self.title.isEmpty ? 0.33 : 1)
                    Section {
                        Button {
                            self.model.insertOnTop([📗Note(self.title, self.comment)])
                            self.showSheet = false
                            💥Feedback.success()
                            Task { @MainActor in
                                try? await Task.sleep(for: .seconds(1))
                                self.title = ""
                                self.comment = ""
                            }
                        } label: {
                            Label("Done", systemImage: "checkmark")
                        }
                        .buttonStyle(.bordered)
                        .listRowBackground(Color.clear)
                        .fontWeight(.semibold)
                        .disabled(self.title.isEmpty)
                        .foregroundStyle(self.title.isEmpty ? .tertiary : .primary)
                    }
                }
                .animation(.default, value: self.title.isEmpty)
            }
            .onOpenURL(perform: self.handleNewNoteShortcut(_:))
    }
    private func handleNewNoteShortcut(_ ⓤrl: URL) {
        if case .newNoteShortcut = 🪧WidgetInfo.load(ⓤrl) {
            self.showSheet = true
        }
    }
}
