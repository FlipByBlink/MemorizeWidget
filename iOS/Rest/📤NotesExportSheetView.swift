import SwiftUI

struct 📤NotesExportSheetView: View {
    @EnvironmentObject var model: 📱AppModel
    @State private var ⓒonvertedText: String?
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Label("Notes count", systemImage: "books.vertical")
                        .badge(self.model.notes.count)
                    if let ⓒonvertedText {
                        ScrollView(.horizontal) {
                            Text(ⓒonvertedText)
                                .font(.subheadline.monospaced().italic())
                                .textSelection(.enabled)
                                .lineLimit(30)
                                .padding()
                        }
                        Label("Copy the above text", systemImage: "hand.point.up.left")
                            .foregroundStyle(.secondary)
                        ShareLink(item: ⓒonvertedText)
                    } else {
                        ProgressView()
                    }
                } header: {
                    Text("Plain text")
                } footer: {
                    Text("This text is TSV(tab-separated values) format.")
                }
            }
            .navigationTitle("Export notes")
            .task { self.ⓒonvertedText = 📚TextConvert.encodeToTSV(self.model.notes) }
            .animation(.default, value: self.ⓒonvertedText == nil)
            .toolbar { 📰DismissButton() }
        }
    }
}
