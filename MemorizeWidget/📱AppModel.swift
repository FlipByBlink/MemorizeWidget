
import SwiftUI

class 📱AppModel: ObservableObject {
    
    @Published var 🗃Notes: [📓Note] = []
    
    @Published var 🆕NewNote: 📓Note = .init("")
    
    @Published var 🚩ShowWidgetNote: Bool = false
    @Published var 🆔WidgetNoteID: String? = nil
    
    @Published var 🚩ShowFileImporter: Bool = false
    @Published var 🚩ShowConfirmFileImportSheet: Bool = false
    @Published var 📓ImportedNotes: [📓Note] = []
    
    private static let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
    @AppStorage("RandomMode", store: ⓤd) var 🚩RandomMode: Bool = false
    @AppStorage("ShowComment", store: ⓤd) var 🚩ShowComment: Bool = false
    
    func 📓GetWidgetNote() -> 📓Note {
        if 🗃Notes.isEmpty {
            return 📓Note("No note")
        } else {
            if 🚩RandomMode {
                return 🗃Notes.randomElement() ?? 📓Note("🐛")
            } else {
                return 🗃Notes.first ?? 📓Note("🐛")
            }
        }
    }
    
    func 💾SaveNotes() {
        do {
            let ⓓata = try JSONEncoder().encode(🗃Notes)
            let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
            ⓤd?.set(ⓓata, forKey: "Notes")
        } catch {
            print("🚨Error: ", error)
        }
    }
    
    func 💾LoadNotes() {
        let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
        guard let ⓓata = ⓤd?.data(forKey: "Notes") else { return }
        do {
            🗃Notes = try JSONDecoder().decode([📓Note].self, from: ⓓata)
        } catch {
            print("🚨Error: ", error)
        }
    }
    
    init() {
        💾LoadNotes()
    }
}


struct 📓Note: Codable, Identifiable, Hashable {
    var title: String
    var comment: String
    var id: UUID
    
    init(_ title: String, _ comment: String = "", _ id: UUID? = nil) {
        self.title = title
        self.comment = comment
        self.id = id ?? UUID()
    }
}


let 🆔AppGroupID = "group.net.aaaakkkkssssttttnnnn.MemorizeWidget"


func 📂ImportTSVFile(_ 📦Result: Result<URL, Error>) -> [📓Note] {
    do {
        var 📚Notes: [📓Note] = []
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
                        📚Notes.append(📓Note(ⓣexts[0]))
                    } else if ⓣexts.count > 1 {
                        if ⓣexts[0] != "" {
                            📚Notes.append(📓Note(ⓣexts[0], ⓣexts[1]))
                        }
                    }
                }
            }
            📦.stopAccessingSecurityScopedResource()
        }
        return 📚Notes
    } catch {
        print("👿", error)
        return []
    }
}
