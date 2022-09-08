
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
        .fileImporter(isPresented: $🚩ImportFile, allowedContentTypes: [.tabSeparatedText]) { 📦Result in
            do {
                let 📦 = try 📦Result.get()
                if 📦.startAccessingSecurityScopedResource() {
                    let ⓦholeText = try String(contentsOf: 📦)
                    print("WholeText: \n", ⓦholeText)
                    let ⓞneLineTexts: [String] = ⓦholeText.components(separatedBy: .newlines)
                    //let ⓞneLineTexts: [String] = ⓦholeText.components(separatedBy: "\r\n") // これだと上手くいく場合があるが環境依存っぽい。あとダブルクオーテーションが残る場合がある。
                    ⓞneLineTexts.forEach { ⓞneline in
                        if ⓞneline != "" {
                            let ⓣexts = ⓞneline.components(separatedBy: "\t")
                            if ⓣexts.count == 1 {
                                📱.🗃Notes.append(📓Note(ⓣexts[0]))
                            } else if ⓣexts.count > 1 {
                                if ⓣexts[0] != "" {
                                    📱.🗃Notes.append(📓Note(ⓣexts[0], ⓣexts[1]))
                                }
                            }
                        }
                    }
                    📦.stopAccessingSecurityScopedResource()
                }
            } catch { print("👿", error) }
        }
    }
}
