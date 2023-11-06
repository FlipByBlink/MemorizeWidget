import SwiftUI

struct 🔩ExportNotesLink: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationLink {
            Self.Destination()
        } label: {
            Label("Export notes as text", systemImage: "square.and.arrow.up")
        }
        .disabled(self.model.notes.isEmpty)
        .animation(.default, value: self.model.notes.isEmpty)
    }
    private struct Destination: View {
        @EnvironmentObject var model: 📱AppModel
        private var text: String { 📚TextConvert.encodeToTSV(self.model.notes) }
        var body: some View {
            List {
                Section {
                    Label("Notes count", systemImage: "books.vertical")
                        .badge(self.model.notes.count)
                    ScrollView(.horizontal) {
                        Text(self.text)
                            .font(.subheadline.monospaced().italic())
                            .textSelection(.enabled)
                            .lineLimit(50)
                            .padding()
                    }
                    Label("Copy the above text", systemImage: "hand.point.up.left")
                        .foregroundStyle(.secondary)
                    ShareLink(item: self.text)
                } header: {
                    Text("Plain text")
                } footer: {
                    Text("This text is TSV(tab-separated values) format.")
                }
            }
            .navigationTitle("Export notes")
        }
    }
}
