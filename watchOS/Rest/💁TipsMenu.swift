import SwiftUI

struct 💁TipsMenu: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        List {
            Section {
                Label("Delete a note by swiping the row.", systemImage: "cursorarrow.motionlines")
                Label("Move a note by drag and drop the row.", systemImage: "hand.draw")
            }
            Section {
                Label("Sync notes between devices by iCloud.", systemImage: "icloud")
                Label("Data limitation is 1 mega byte.", systemImage: "exclamationmark.icloud")
                Label("If the data size is exceeded, please reduce the number of notes or clear the trash.",
                      systemImage: "externaldrive.badge.xmark")
                VStack {
                    LabeledContent {
                        Text(self.model.notes.dataCount.formatted(.byteCount(style: .file)))
                    } label: {
                        Label("Notes data count", systemImage: "books.vertical")
                    }
                    if self.model.exceedDataSizePerhaps {
                        Text("⚠️ NOTICE DATA LIMITATION")
                            .font(.headline)
                            .foregroundColor(.red)
                    }
                }
            } header: {
                Text("Data")
            }
        }
        .navigationTitle("Tips")
    }
}
