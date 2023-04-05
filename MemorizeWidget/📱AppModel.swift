import SwiftUI
import WidgetKit

class 📱AppModel: ObservableObject {
    @Published var 📚notes: 📚Notes
    
    @Published var 🔖tab: 🔖Tab = .notesList
    
    @Published var 🪧widgetState: 🪧WidgetState = .default
    
    @Published var 🚩showNotesImportSheet: Bool = false
    
    
    @Published var 🗑trashBox: 🗑TrashBoxModel = .load()
    
    @AppStorage("RandomMode", store: .ⓐppGroup) var 🚩randomMode: Bool = false
    
    init() {
        self.📚notes = 💾UserDefaults.loadNotes() ?? .sample
        self.📚notes.cleanEmptyTitleNotes()
    }
}

//MARK: ComputedProperty, Method
extension 📱AppModel {
    func addNewNote(_ ⓘndex: Int) {
        withAnimation {
            self.📚notes.insert(.empty, at: ⓘndex)
        }
        UISelectionFeedbackGenerator().selectionChanged()
    }
    
    func addNewNoteOnTop() { self.addNewNote(0) }
    
    func handleLeavingApp(_ ⓞldPhase: ScenePhase, _ ⓝewPhase: ScenePhase) {
        if ⓞldPhase == .active, ⓝewPhase == .inactive {
            💾UserDefaults.save(self.📚notes)
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    func handleWidgetURL(_ ⓤrl: URL) {
        Task { @MainActor in
            self.🚩showNotesImportSheet = false
            self.🪧widgetState.showSheet = false
            if let ⓘnfo = 🪧WidgetInfo.load(ⓤrl) {
                switch ⓘnfo {
                    case .singleNote(_), .multiNotes(_):
                        self.🪧widgetState = 🪧WidgetState(showSheet: true, info: ⓘnfo)
                    case .newNoteShortcut, .noNote:
                        break
                }
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            } else {
                assertionFailure()
            }
            self.🔖tab = .notesList
        }
    }
}
