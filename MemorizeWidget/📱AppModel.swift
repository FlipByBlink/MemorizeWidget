
import SwiftUI

class 📱AppModel: ObservableObject {
    
    @Published var 🗃Items: [🗒Item] = []
    
    @Published var 🆕Item: 🗒Item = .init("")
    
    @Published var 🚩ShowWidgetItem: Bool = false
    @Published var 🆔WidgetItem: String? = nil
    
    @AppStorage("RandomMode", store: 💾AppGroupData) var 🚩RandomMode: Bool = false
    
    func 🗒GetWidgetItem() -> 🗒Item {
        if 🗃Items.isEmpty {
            return 🗒Item("No item")
        } else {
            if 🚩RandomMode {
                return 🗃Items.randomElement() ?? 🗒Item("🐛")
            } else {
                return 🗃Items.first ?? 🗒Item("🐛")
            }
        }
    }
    
    func 💾SaveItems() {
        var 📦Items: [[String]] = []
        🗃Items.forEach { 🗒 in
            📦Items.append([🗒.ⓣitle, 🗒.ⓒomment, 🗒.id.uuidString])
        }
        💾AppGroupData?.set(📦Items, forKey: "Items")
    }
    
    func 💾LoadItems() {
        if let 📦Items = 💾AppGroupData?.object(forKey: "Items") as? [[String]] {
            🗃Items = []
            📦Items.forEach { ⓘtems in
                if ⓘtems.count == 3 {
                    🗃Items.append(.init(ⓘtems[0], ⓘtems[1], UUID(uuidString: ⓘtems[2])))
                }
            }
        }
    }
    
    init() {
        💾LoadItems()
    }
}


let 💾AppGroupData = UserDefaults(suiteName: "group.net.aaaakkkkssssttttnnnn.MemorizeWidget")


struct 🗒Item: Identifiable, Hashable {
    var ⓣitle: String
    var ⓒomment: String
    var id: UUID
    
    init(_ ⓣitle: String, _ ⓒomment: String = "", _ id: UUID? = nil) {
        self.ⓣitle = ⓣitle
        self.ⓒomment = ⓒomment
        self.id = id ?? UUID()
    }
}
