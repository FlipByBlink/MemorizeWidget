import SwiftUI

struct 👇InsertBelowButton: View {
    @EnvironmentObject var model: 📱AppModel
    var notes: Set<📗Note>
    var body: some View {
        Button {
        } label: {
            Label("Insert below", systemImage: "")
        }
    }
}
