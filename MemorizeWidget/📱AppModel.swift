
import SwiftUI

class 📱AppModel: ObservableObject {
    @Published var 🗃Notes: [📓Note] = 🗃SampleNotes
    @Published var 🚩ShowNoteSheet: Bool = false
    @Published var 🆔OpenedNoteID: String? = nil
    @Published var 🚩ShowImportSheet: Bool = false
    
    private static let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
    @AppStorage("RandomMode", store: ⓤd) var 🚩RandomMode: Bool = false
    @AppStorage("ShowComment", store: ⓤd) var 🚩ShowComment: Bool = false
    @AppStorage("SearchLeadingText") var 🔗Leading: String = ""
    @AppStorage("SearchTrailingText") var 🔗Trailing: String = ""
    
    func 🆕AddNewNote(_ ⓘndex: Int = 0) {
        🗃Notes.insert(📓Note(""), at: ⓘndex)
        UISelectionFeedbackGenerator().selectionChanged()
    }
    
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


class 🚛ImportProcessModel: ObservableObject {
    @AppStorage("separator") var ⓢeparator: 🅂eparator = .tab
    @Published var ⓘnputText: String = ""
    @Published var ⓞutputNotes: [📓Note] = []
    
    func 🄸mportFile(_ 📦Result: Result<URL, Error>) throws {
        let 📦 = try 📦Result.get()
        if 📦.startAccessingSecurityScopedResource() {
            ⓘnputText = try String(contentsOf: 📦)
            📦.stopAccessingSecurityScopedResource()
        }
    }
    
    func 🄲onvertTextToNotes() {
        var 📚Notes: [📓Note] = []
        let ⓞneLineTexts: [String] = ⓘnputText.components(separatedBy: .newlines)
        ⓞneLineTexts.forEach { ⓞneLine in
            if !ⓞneLine.isEmpty {
                if ⓢeparator == .titleOnly {
                    📚Notes.append(📓Note(ⓞneLine))
                } else {
                    let ⓣexts = ⓞneLine.components(separatedBy: ⓢeparator.rawValue)
                    if let ⓣitle = ⓣexts.first {
                        if !ⓣitle.isEmpty {
                            let ⓒomment = ⓞneLine.dropFirst(ⓣitle.count + 1).description
                            📚Notes.append(📓Note(ⓣitle, ⓒomment))
                        }
                    }
                }
            }
        }
        ⓞutputNotes = 📚Notes
    }
}

enum 🅂eparator: String {
    case tab = "\t"
    case comma = ","
    case titleOnly = ""
}


let 🗃SampleNotes: [📓Note] = [📓Note("Lemon", "Yellow Sour"),
                               📓Note("Strawberry", "jam red sweet"),
                               📓Note("Grape", "seedless / wine / white / black")]
