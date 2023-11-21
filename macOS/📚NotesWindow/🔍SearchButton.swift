import SwiftUI

struct 🔍SearchButton: View {
    @StateObject var searchModel: 🔍SearchModel = .init()
    @Environment(\.openURL) var openURL
    private var notes: Set<📗Note>
    var body: some View {
        Button {
            guard let ⓠuery = self.notes.first?.title else {
                NSSound.beep()
                return
            }
            self.openURL(self.searchModel.generateURL(ⓠuery))
        } label: {
            Label("Search", systemImage: "magnifyingglass")
        }
        .disabled(self.notes.count != 1)
        .modifier(🔍FailureAlert(self.searchModel))
    }
    init(_ notes: Set<📗Note>) {
        self.notes = notes
    }
}
