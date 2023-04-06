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
        self.🗑trash.cleanExceededContents()
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
    private func addNewNote(index ⓘndex: Int) {
        self.📚notes.insert(.empty, at: ⓘndex)
        UISelectionFeedbackGenerator().selectionChanged()
    }
    func addNewNoteOnTop() {
        self.addNewNote(index: 0)
    }
    func addNewNoteBelow(_ ⓝote: 📗Note) {
        guard let ⓘndex = self.📚notes.firstIndex(of: ⓝote) else { return }
        self.addNewNote(index: ⓘndex + 1)
    }
    func moveTop(_ ⓝote: 📗Note) {
        guard let ⓘndex = self.📚notes.firstIndex(of: ⓝote) else { return }
        self.📚notes.move(fromOffsets: [ⓘndex], toOffset: 0)
    }
    func moveEnd(_ ⓝote: 📗Note) {
        guard let ⓘndex = self.📚notes.firstIndex(of: ⓝote) else { return }
        self.📚notes.move(fromOffsets: [ⓘndex], toOffset: self.📚notes.endIndex)
    }
    func removeNote(_ ⓝote: 📗Note) {
        self.🗑trash.storeDeletedNotes([ⓝote])
        withAnimation { self.📚notes.removeAll(where: { $0 == ⓝote }) }
        UINotificationFeedbackGenerator().notificationOccurred(.warning)
    }
    func removeAllNotes() {
        self.🗑trash.storeDeletedNotes(self.📚notes)
        self.📚notes.removeAll()
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
    func insertOnTop(_ ⓝotes: 📚Notes) {
        self.📚notes.insert(contentsOf: ⓝotes, at: 0)
    }
    func restore(_ ⓒontent: 🄳eletedContent) {
        let ⓡestoredNotes = ⓒontent.notes.map { 📗Note($0.title, $0.comment) }
        self.insertOnTop(ⓡestoredNotes)
        self.🗑trash.remove(ⓒontent)
        UISelectionFeedbackGenerator().selectionChanged()
    }
    func reloadNotes() {
        guard let ⓝotes = 💾UserDefaults.loadNotes() else { return }
        self.📚notes = ⓝotes
    }
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
