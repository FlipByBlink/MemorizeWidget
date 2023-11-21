import SwiftUI

struct 👆InsertAboveButton: View {
    @EnvironmentObject var model: 📱AppModel
    var notes: Set<📗Note>
    var body: some View {
        Button {
        } label: {
            Label("Insert above", systemImage: "")
        }
    }
}
