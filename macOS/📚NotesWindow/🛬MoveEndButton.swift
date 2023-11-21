import SwiftUI

struct 🛬MoveEndButton: View {
    @EnvironmentObject var model: 📱AppModel
    var notes: Set<📗Note>
    var body: some View {
        Button {
        } label: {
            Label("Move end", systemImage: "")
        }
    }
}
