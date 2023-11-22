import SwiftUI

struct 📤NotesExportSheetView: View {
    @EnvironmentObject var model: 📱AppModel
    @State private var ⓒonvertedText: String?
    var body: some View {
        NavigationStack {
            Group {
                if let ⓒonvertedText {
                    Self.exampleView(ⓒonvertedText)
                } else {
                    ZStack {
                        Color.clear
                        ProgressView()
                    }
                }
            }
            .navigationTitle(self.navigationTitle)
            .toolbar { self.dismissButton() }
        }
        .animation(.default, value: self.ⓒonvertedText == nil)
        .task { self.ⓒonvertedText = 📚TextConvert.encodeToTSV(self.model.notes) }
        .frame(width: 500, height: 440)
    }
}

private extension 📤NotesExportSheetView {
    private var navigationTitle: LocalizedStringKey {
        if self.model.notes.isEmpty {
            "Export notes as tsv text"
        } else if self.model.notes.count == 1 {
            "Export a note as tsv text"
        } else {
            "Export \(self.model.notes.count) notes as tsv text"
        }
    }
    private static func exampleView(_ ⓒonvertedText: String) -> some View {
        ScrollView {
            Text(ⓒonvertedText)
                .font(.subheadline.monospaced().italic())
                .textSelection(.enabled)
                .padding()
        }
    }
    private func dismissButton() -> some ToolbarContent {
        ToolbarItem(placement: .automatic) {
            Button("Dismiss") {
                self.model.presentedSheetOnContentView = nil
            }
        }
    }
}
