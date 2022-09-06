
import SwiftUI

class 📱AppModel: ObservableObject {
    
    @Published var 🗃Notes: [📓Note] = []
    
    @Published var 🆕NewNote: 📓Note = .init("")
    
    @Published var 🚩ShowWidgetNote: Bool = false
    @Published var 🆔WidgetNoteID: String? = nil
    
    @AppStorage("RandomMode", store: 💾AppGroupData) var 🚩RandomMode: Bool = false
    
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
//        var 📦Items: [[String]] = []
//        🗃Notes.forEach { 🗒 in
//            📦Items.append([🗒.title, 🗒.comment, 🗒.id.uuidString])
//        }
//        💾AppGroupData?.set(📦Items, forKey: "Items")
    }
    
    func 💾LoadNotes() {
//        if let 📦Items = 💾AppGroupData?.object(forKey: "Items") as? [[String]] {
//            🗃Notes = []
//            📦Items.forEach { ⓘtems in
//                if ⓘtems.count == 3 {
//                    🗃Notes.append(.init(ⓘtems[0], ⓘtems[1], UUID(uuidString: ⓘtems[2])))
//                }
//            }
//        }
    }
    
    init() {
        💾LoadNotes()
    }
}


let 💾AppGroupData = UserDefaults(suiteName: "group.net.aaaakkkkssssttttnnnn.MemorizeWidget")


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
