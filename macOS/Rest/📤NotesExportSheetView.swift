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
                    }
                } footer: {
                    Text("This text is TSV(tab-separated values) format.")
                }
            }
            .navigationTitle("Export notes")
            .task { self.ⓒonvertedText = 📚TextConvert.encodeToTSV(self.model.notes) }
            .animation(.default, value: self.ⓒonvertedText == nil)
            .toolbar {
                self.shareLink()
                self.dismissButton()
            }
        }
        .frame(width: 500, height: 440)
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
                .padding(.bottom, 6)
                .mask {
                    LinearGradient(colors: [.white, .clear],
                                   startPoint: .init(x: 0.5, y: 0.7),
                                   endPoint: .init(x: 0.5, y: 1.0))
                }
        }
        .background {
            Text("Example")
                .font(.system(size: 50, weight: .heavy, design: .rounded))
                .foregroundStyle(.quaternary)
                .rotationEffect(.degrees(10))
        }
    }
    private func shareLink() -> some ToolbarContent {
        ToolbarItem(placement: .automatic) {
            if let ⓒonvertedText {
                ShareLink(item: ⓒonvertedText)
            } else {
                ProgressView()
            }
        }
    }
    private func dismissButton() -> some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button {
                self.model.presentedSheetOnContentView = nil
            } label: {
                Label("Dismiss", systemImage: "xmark")
            }
        }
    }
}
