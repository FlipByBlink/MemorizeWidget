import SwiftUI

struct 🔖TabView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        TabView(selection: self.$model.selectedTab) {
            ForEach(🔖Tab.allCases, content: \.detailView)
        }
    }
}
