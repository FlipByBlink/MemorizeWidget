import SwiftUI

struct 💁GuideMenu: View {
    var body: some View {
        List {
            Section {
                Label("Delete a note by swiping the row.", 
                      systemImage: "cursorarrow.motionlines")
                Label("Move a note by drag and drop the row.", 
                      systemImage: "hand.draw")
            }
            Section {
                💁GuideViewComponent.AboutDataSync()
                💁GuideViewComponent.AboutDataCount()
            } header: {
                Text("Data")
            }
        }
        .navigationTitle("Guide")
    }
}
