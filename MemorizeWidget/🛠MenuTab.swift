
import SwiftUI
import WidgetKit

struct 🛠MenuTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🚩ImportFile: Bool = false
    
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
                
                Button {
                    🚩ImportFile.toggle()
                } label: {
                    Label("Import TSV file", systemImage: "arrow.down.doc")
                }
                
                📣ADMenuLink()
            }
            .navigationTitle("Menu")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fileImporter(isPresented: $🚩ImportFile, allowedContentTypes: [.tabSeparatedText]) { ⓡesult in
            switch ⓡesult { //TODO: 実装
                case .success(let success):
                    print(success)
                case .failure(let failure):
                    print(failure)
            }
        }
    }
}
