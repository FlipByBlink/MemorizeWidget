import SwiftUI

class 📱AppModel: ObservableObject {
    @Published var 📚notes: 📚Notes = .load() ?? .sample
    
    @Published var 🔖tab: 🔖Tab = .notesList
    
    @Published var 🚩showWidgetNoteSheet: Bool = false
    @Published var 🆔widgetNotesID: [UUID] = []
    
    @Published var 🚩showNotesImportSheet: Bool = false
    
    @AppStorage("RandomMode", store: .ⓐppGroup) var 🚩randomMode: Bool = false
    
    init() {
        self.📚notes.cleanEmptyTitleNotes()
    }
}

//MARK: ComputedProperty, Method
extension 📱AppModel {
    func addNewNote(_ ⓘndex: Int = 0) {
        withAnimation {
            self.📚notes.insert(📗Note(""), at: ⓘndex)
        }
        UISelectionFeedbackGenerator().selectionChanged()
    }
    
    func handleWidgetURL(_ ⓤrl: URL) {
        Task { @MainActor in
            self.🚩showNotesImportSheet = false
            self.🚩showWidgetNoteSheet = false
            switch 🔗WidgetLink.load(ⓤrl) {
                case .notes(let ⓘds):
                    self.🆔widgetNotesID = ⓘds
                    self.🚩showWidgetNoteSheet = true
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                case .newNoteShortcut:
                    self.addNewNote()
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                case .none:
                    assertionFailure()
            }
            self.🔖tab = .notesList
        }
    }
}

struct 🪧WidgetState {
    var showSheet: Bool = false
    var type: 🅃ype? = nil
    enum 🅃ype {
        case singleNote(UUID), multiNotes([UUID]), newNoteShortcut
        var path: String {
            switch self {
                case .singleNote(let ⓘd):
                    return "example://\(ⓘd.uuidString)"
                case .multiNotes(let ⓘds):
                    var ⓓescription: String = ""
                    for ⓘd in ⓘds {
                        ⓓescription += ⓘd.uuidString
                        if ⓘd == ⓘds.last { break }
                        ⓓescription += "/"
                    }
                    print(ⓓescription)
                    return "example://\(ⓓescription)"
                case .newNoteShortcut:
                    return "example://NewNoteShortcut"
            }
        }
        var url: URL { URL(string: self.path)! }
        static func load(_ ⓤrl: URL) -> Self? {
            if ⓤrl.pathComponents.count == 1 {
                if ⓤrl.path == "NewNoteShortcut" {
                    return Self.newNoteShortcut
                } else {
                    guard let ⓘd = UUID(uuidString: ⓤrl.path) else { return nil }
                    return Self.singleNote(ⓘd)
                }
            } else {
                return Self.multiNotes(ⓤrl.pathComponents.compactMap { UUID(uuidString: $0) })
            }
        }
    }
}
