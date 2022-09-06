
import SwiftUI

class 📱AppModel: ObservableObject {
    
    @Published var 🗃Notes: [📓Note] = []
    
    @Published var 🆕NewNote: 📓Note = .init("")
    
    @Published var 🚩ShowWidgetNote: Bool = false
    @Published var 🆔WidgetNoteID: String? = nil
    
    @AppStorage("RandomMode", store: UserDefaults(suiteName: 🆔AppGroupID)) var 🚩RandomMode: Bool = false
    
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
