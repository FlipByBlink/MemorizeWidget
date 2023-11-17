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
                        Self.exampleView(ⓒonvertedText)
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

private extension 📤NotesExportSheetView {
    private static func exampleView(_ ⓒonvertedText: String) -> some View {
        ScrollView(.horizontal) {
            Text(ⓒonvertedText)
                .font(.subheadline.monospaced().italic())
                .textSelection(.enabled)
                .lineLimit(16)
                .padding(.top)
                .padding(.horizontal)
        }
        .background {
            Text("Example")
                .font(.system(size: 50,
                              weight: .heavy,
                              design: .rounded))
                .foregroundStyle(.quaternary)
                .rotationEffect(.degrees(10))
        }
        .mask {
            LinearGradient(colors: [.white, .clear],
                           startPoint: .init(x: 0.5, y: 0.8),
                           endPoint: .init(x: 0.5, y: 1.0))
        }
    }
}
