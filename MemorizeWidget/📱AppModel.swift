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
            if ⓤrl.description == "NewNoteShortcut" {
                self.addNewNote()
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            } else if self.📚notes.contains(where: { $0.id.description == ⓤrl.description }) {
                self.🚩showWidgetNoteSheet = true
                guard let ⓤuid = UUID(uuidString: ⓤrl.description) else { assertionFailure(); return }
                self.🆔widgetNotesID = [ⓤuid]
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
            self.🔖tab = .notesList
        }
    }
}
