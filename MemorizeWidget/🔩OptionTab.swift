
import SwiftUI
import WidgetKit

struct 🔩OptionTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: 📱.$🚩ShowComment) {
                    Label("Show comment on widget", systemImage: "list.dash.header.rectangle")
                }
                .onChange(of: 📱.🚩ShowComment) { _ in
                    WidgetCenter.shared.reloadAllTimelines()
                }
                
                Toggle(isOn: 📱.$🚩RectangularBackground) {
                    Label("Show rectangular background on lock screen", systemImage: "rectangle.dashed")
                }
                .onChange(of: 📱.🚩RectangularBackground) { _ in
                    WidgetCenter.shared.reloadAllTimelines()
                }
                
                📣ADMenuLink()
            }
            .navigationTitle("Option")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
