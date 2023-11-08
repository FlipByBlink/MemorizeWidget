import SwiftUI

enum 💁GuideViewComponent {
    struct AboutDataSync: View {
        var body: some View {
            Label("Sync notes between devices by iCloud.", systemImage: "icloud")
            Label("Data limitation is 1 mega byte.", systemImage: "exclamationmark.icloud")
            Label("If the data size is exceeded, please reduce the number of notes or clear the trash.",
                  systemImage: "externaldrive.badge.xmark")
        }
    }
    struct AboutDataCount: View {
        @EnvironmentObject var model: 📱AppModel
        var body: some View {
            LabeledContent {
                Text(self.model.notes.dataCount.formatted(.byteCount(style: .file)))
            } label: {
                Label("Notes data count", systemImage: "books.vertical")
            }
            if self.model.exceedDataSizePerhaps {
                Text("⚠️ NOTICE DATA LIMITATION")
                    .font(.headline)
                    .foregroundStyle(.red)
            }
        }
    }
}
