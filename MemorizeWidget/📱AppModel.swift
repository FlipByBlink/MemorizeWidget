
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




let 📚SampleNotes: [📗Note] = 🄲onvertTextToNotes("""
Lemon,yellow sour
Strawberry,jam red sweet
Grape,seedless wine white black
""", .comma)
