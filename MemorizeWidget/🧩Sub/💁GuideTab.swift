import SwiftUI

struct 💁GuideTab: View {
    @EnvironmentObject var 🛒: 🛒StoreModel
    var body: some View {
        NavigationView {
            List {
                🄳eleteNoteBySwiping()
                if #available(iOS 16.0, *) { 🄳irectionsSection() }
            }
            .navigationTitle("Guide")
        }
        .navigationViewStyle(.stack)
    }
}

private struct 🄳eleteNoteBySwiping: View {
    var body: some View {
        Section {
            Text("Delete a note by swiping the row.")
            HStack {
                Image(systemName: "hand.point.up.left")
                Image(systemName: "arrowshape.left")
            }
        }
    }
}

private struct 🄳irectionsSection: View {
    var body: some View {
        Section {
            Text("If lock screen widgets don't update, please close this app or switch to another app.")
        } header: {
            Text("Directions")
        }
    }
}
