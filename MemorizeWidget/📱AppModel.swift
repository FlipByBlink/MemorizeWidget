
import SwiftUI
import WidgetKit

class 📱AppModel: ObservableObject {
    @Published var 📚notes: [📗Note]
    @Published var 🚩showNoteSheet: Bool = false
    @Published var 🆔openedNoteID: String? = nil
    @Published var 🚩showImportSheet: Bool = false
    
    private static let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
    @AppStorage("RandomMode", store: ⓤd) var 🚩randomMode: Bool = false
    @AppStorage("ShowComment", store: ⓤd) var 🚩showComment: Bool = false
    @AppStorage("SearchLeadingText") var 🔗Leading: String = ""
    @AppStorage("SearchTrailingText") var 🔗Trailing: String = ""
    
    func 🆕addNewNote(_ ⓘndex: Int = 0) {
        📚notes.insert(📗Note(""), at: ⓘndex)
        UISelectionFeedbackGenerator().selectionChanged()
    }
    
    func 📗getWidgetNote() -> 📗Note { //FIXME: リファクタリング
        if 📚notes.isEmpty {
            return 📗Note("No note")
        } else {
            if 🚩randomMode {
                return 📚notes.randomElement() ?? 📗Note("🐛")
            } else {
                return 📚notes.first ?? 📗Note("🐛")
            }
        }
    }
    
    func 🆕addNotesFromWidget(_ ⓝewNotes: [📗Note]) {
        var ⓝotes = 💾DataManager.notes ?? []
        ⓝotes.insert(contentsOf: ⓝewNotes, at: 0)
        💾DataManager.save(ⓝotes)
    }
    
    func 💾LoadNotesData() {
        if let ⓝotes = 💾DataManager.notes {
            📚notes = ⓝotes
        } else {
            print("📢 No data.")
        }
    }
    
    init() {
        📚notes = 💾DataManager.notes ?? 📚SampleNotes
    }
}


struct 📗Note: Codable, Identifiable, Hashable {
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


struct 💾DataManager {
    static let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
    static func save(_ ⓝotes: [📗Note]) {
        do {
            let ⓓata = try JSONEncoder().encode(ⓝotes)
            ⓤd?.set(ⓓata, forKey: "Notes")
        } catch {
            print("🚨:", error)
        }
    }
    static var notes: [📗Note]? {
        guard let ⓓata = ⓤd?.data(forKey: "Notes") else { return nil }
        do {
            return try JSONDecoder().decode([📗Note].self, from: ⓓata)
        } catch {
            print("🚨:", error)
            return nil
        }
    }
}


class 🚛ImportProcessModel: ObservableObject {
    @AppStorage("separator") var ⓢeparator: 🅂eparator = .tab
    @Published var ⓘnputText: String = ""
    @Published var ⓞutputNotes: [📗Note] = []
    
    func 🄸mportFile(_ 📦Result: Result<URL, Error>) throws {
        let 📦 = try 📦Result.get()
        if 📦.startAccessingSecurityScopedResource() {
            ⓘnputText = try String(contentsOf: 📦)
            📦.stopAccessingSecurityScopedResource()
        }
    }
    func convertTextToNotes() {
        ⓞutputNotes = 🄲onvertTextToNotes(ⓘnputText, ⓢeparator)
    }
}

func 🄲onvertTextToNotes(_ ⓘnputText: String, _ ⓢeparator: 🅂eparator) -> [📗Note] {
    var ⓝotes: [📗Note] = []
    let ⓞneLineTexts: [String] = ⓘnputText.components(separatedBy: .newlines)
    ⓞneLineTexts.forEach { ⓞneLine in
        if !ⓞneLine.isEmpty {
            if ⓢeparator == .titleOnly {
                ⓝotes.append(📗Note(ⓞneLine))
            } else {
                let ⓣexts = ⓞneLine.components(separatedBy: ⓢeparator.rawValue)
                if let ⓣitle = ⓣexts.first {
                    if !ⓣitle.isEmpty {
                        let ⓒomment = ⓞneLine.dropFirst(ⓣitle.count + 1).description
                        ⓝotes.append(📗Note(ⓣitle, ⓒomment))
                    }
                }
            }
        }
    }
    return ⓝotes
}

enum 🅂eparator: String {
    case tab = "\t"
    case comma = ","
    case titleOnly = ""
}




let 📚SampleNotes: [📗Note] = 🄲onvertTextToNotes("""
Lemon,yellow sour
Strawberry,jam red sweet
Grape,seedless wine white black
""", .comma)
