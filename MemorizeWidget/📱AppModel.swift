
import SwiftUI
import WidgetKit

class 📱AppModel: ObservableObject {
    @Published var 🗃Notes: [📗Note] = 🗃SampleNotes
    @Published var 🚩ShowNoteSheet: Bool = false
    @Published var 🆔OpenedNoteID: String? = nil
    @Published var 🚩ShowImportSheet: Bool = false
    
    private static let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
    @AppStorage("RandomMode", store: ⓤd) var 🚩RandomMode: Bool = false
    @AppStorage("ShowComment", store: ⓤd) var 🚩ShowComment: Bool = false
    @AppStorage("SearchLeadingText") var 🔗Leading: String = ""
    @AppStorage("SearchTrailingText") var 🔗Trailing: String = ""
    
    func 🆕addNewNote(_ ⓘndex: Int = 0) {
        🗃Notes.insert(📗Note(""), at: ⓘndex)
        UISelectionFeedbackGenerator().selectionChanged()
    }
    
    func 📗getWidgetNote() -> 📗Note {
        if 🗃Notes.isEmpty {
            return 📗Note("No note")
        } else {
            if 🚩RandomMode {
                return 🗃Notes.randomElement() ?? 📗Note("🐛")
            } else {
                return 🗃Notes.first ?? 📗Note("🐛")
            }
        }
    }
    
    func 🚥applyDataAndWidgetAccordingAsScene(before: ScenePhase, after: ScenePhase) {
        if before != .active && after == .active {
            💾loadNotesData()
        } else if before == .active && after != .active {
            💾saveNotesData()
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    private func 💾saveNotesData() {
        do {
            let ⓓata = try JSONEncoder().encode(🗃Notes)
            let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
            ⓤd?.set(ⓓata, forKey: "Notes")
        } catch {
            print("🚨: ", error)
        }
    }
    
    private func 💾loadNotesData() {
        let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
        guard let ⓓata = ⓤd?.data(forKey: "Notes") else { return }
        do {
            🗃Notes = try JSONDecoder().decode([📗Note].self, from: ⓓata)
        } catch {
            print("🚨: ", error)
        }
    }
    
    init() {
        💾loadNotesData()
        let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
        if let ⓓata = ⓤd?.data(forKey: "DataFromExtension") {
            if let ⓢtockedNotes = try? JSONDecoder().decode([📗Note].self, from: ⓓata) {
                🗃Notes.insert(contentsOf: ⓢtockedNotes, at: 0)
                ⓤd?.set(Data(), forKey: "DataFromExtension")
                💾saveNotesData()
            }
        }
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


//FIXME: 実装やめるか検討
struct 📚ShareExtensionManeger {
    static var stockedNotes: [📗Note] {
        let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
        guard let ⓓata = ⓤd?.data(forKey: "DataFromExtension") else { return [] }
        do {
            return try JSONDecoder().decode([📗Note].self, from: ⓓata)
        } catch {
            print("🚨:", error)
            return []
        }
    }
    
    static func save(_ ⓝotes: [📗Note]) {
        var ⓝewStockedNotes: [📗Note] = []
        ⓝewStockedNotes.append(contentsOf: ⓝotes)
        if !stockedNotes.isEmpty {
            ⓝewStockedNotes.append(contentsOf: stockedNotes)
        }
        do {
            let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
            let ⓓata = try JSONEncoder().encode(ⓝewStockedNotes)
            ⓤd?.set(ⓓata, forKey: "DataFromExtension")
        } catch {
            print("🚨:", error)
        }
    }
}


let 🆔AppGroupID = "group.net.aaaakkkkssssttttnnnn.MemorizeWidget"


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
    var 📚notes: [📗Note] = []
    let ⓞneLineTexts: [String] = ⓘnputText.components(separatedBy: .newlines)
    ⓞneLineTexts.forEach { ⓞneLine in
        if !ⓞneLine.isEmpty {
            if ⓢeparator == .titleOnly {
                📚notes.append(📗Note(ⓞneLine))
            } else {
                let ⓣexts = ⓞneLine.components(separatedBy: ⓢeparator.rawValue)
                if let ⓣitle = ⓣexts.first {
                    if !ⓣitle.isEmpty {
                        let ⓒomment = ⓞneLine.dropFirst(ⓣitle.count + 1).description
                        📚notes.append(📗Note(ⓣitle, ⓒomment))
                    }
                }
            }
        }
    }
    return 📚notes
}

enum 🅂eparator: String {
    case tab = "\t"
    case comma = ","
    case titleOnly = ""
}




let 🗃SampleNotes: [📗Note] = 🄲onvertTextToNotes("""
Lemon,yellow sour
Strawberry,jam red sweet
Grape,seedless wine white black
""", .comma)
