import SwiftUI
import WidgetKit

class 📱AppModel: ObservableObject {
    @Published var 📚notes: 📚Notes
    
    @Published var 🔖tab: 🔖Tab = .notesList
    
    @Published var 🪧widgetState: 🪧WidgetState = .default
    
    @Published var 🚩showNotesImportSheet: Bool = false
    
    @Published var 🗑trash: 🗑TrashModel = .load()
    
    @AppStorage("RandomMode", store: .ⓐppGroup) var 🚩randomMode: Bool = false
    
    init() {
        self.📚notes = 💾UserDefaults.loadNotes() ?? .sample
        self.📚notes.cleanEmptyTitleNotes()
        self.🗑trash.cleanExceededContent()
    }
}

//MARK: ComputedProperty, Method
extension 📱AppModel {
    func deleteNote(_ ⓘndexSet: IndexSet) {
        guard let ⓘndex = ⓘndexSet.first else { return }
        self.🗑trash.storeDeletedNotes([self.📚notes[ⓘndex]])
        self.📚notes.remove(atOffsets: ⓘndexSet)
    }
    
    func moveNote(_ ⓢource: IndexSet, _ ⓓestination: Int) {
        self.📚notes.move(fromOffsets: ⓢource, toOffset: ⓓestination)
    }
    
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
            self.🗑trash.save()
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
