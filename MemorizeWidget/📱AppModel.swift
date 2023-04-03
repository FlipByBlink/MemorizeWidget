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
