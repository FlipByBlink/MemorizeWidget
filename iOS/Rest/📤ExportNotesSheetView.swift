import SwiftUI

struct 📤ExportNotesSheetView: View {
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
                        .lineLimit(30)
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
