import SwiftUI
import WidgetKit

class 📱AppModel: ObservableObject {
    @Published var 📚notes: 📚Notes
    @Published var 🔖tab: 🔖Tab = .notesList
    @Published var 🆕newNoteID: UUID? = nil
    @Published var 🪧widgetState: 🪧WidgetState = .default
    @Published var 🚩showNotesImportSheet: Bool = false
    @Published var 🗑trash: 🗑TrashModel = .load()
    @AppStorage("RandomMode", store: .ⓐppGroup) var 🚩randomMode: Bool = false
    init() {
        💾ICloud.api.synchronize()
        self.📚notes = 💾ICloud.loadNotes() ?? .sample
        self.📚notes.cleanEmptyTitleNotes()
        self.🗑trash.cleanExceededContents()
        💾ICloud.addObserver(self, #selector(self.iCloudDidChange(_:)))
        self.forwardFromUserDefaults_1_1_2()
    }
}

//MARK: ComputedProperty, Method
extension 📱AppModel {
    func deleteNote(_ ⓘndexSet: IndexSet) {
        guard let ⓘndex = ⓘndexSet.first else { return }
        self.🗑trash.storeDeletedNotes([self.📚notes[ⓘndex]])
        self.📚notes.remove(atOffsets: ⓘndexSet)
        self.saveNotes()
    }
    func moveNote(_ ⓢource: IndexSet, _ ⓓestination: Int) {
        self.📚notes.move(fromOffsets: ⓢource, toOffset: ⓓestination)
        self.saveNotes()
    }
    private func addNewNote(index ⓘndex: Int) {
        let ⓝewNote: 📗Note = .empty
        self.📚notes.insert(ⓝewNote, at: ⓘndex)
        self.🆕newNoteID = ⓝewNote.id
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
        self.saveNotes()
        UISelectionFeedbackGenerator().selectionChanged()
    }
    func moveEnd(_ ⓝote: 📗Note) {
        guard let ⓘndex = self.📚notes.firstIndex(of: ⓝote) else { return }
        self.📚notes.move(fromOffsets: [ⓘndex], toOffset: self.📚notes.endIndex)
        self.saveNotes()
        UISelectionFeedbackGenerator().selectionChanged()
    }
    func removeNote(_ ⓝote: 📗Note, feedback ⓕeedback: Bool = true) {
        self.🗑trash.storeDeletedNotes([ⓝote])
        withAnimation { self.📚notes.removeAll(where: { $0 == ⓝote }) }
        self.saveNotes()
        if ⓕeedback {
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
        }
    }
    func apply(_ ⓘnputtedNote: 📗Note, target ⓣargetNote: 📗Note) {
        guard let ⓘndex = self.📚notes.firstIndex(of: ⓣargetNote) else { return }
        self.📚notes[ⓘndex].title = ⓘnputtedNote.title
        self.📚notes[ⓘndex].comment = ⓘnputtedNote.comment
        self.saveNotes()
    }
    func removeAllNotes() {
        self.🗑trash.storeDeletedNotes(self.📚notes)
        self.📚notes.removeAll()
        self.saveNotes()
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
    func insertOnTop(_ ⓝotes: 📚Notes) {
        self.📚notes.insert(contentsOf: ⓝotes, at: 0)
        self.saveNotes()
    }
    func restore(_ ⓒontent: 🄳eletedContent) {
        let ⓡestoredNotes = ⓒontent.notes.map { 📗Note($0.title, $0.comment) }
        self.insertOnTop(ⓡestoredNotes)
        self.🗑trash.remove(ⓒontent)
        self.saveNotes()
        UISelectionFeedbackGenerator().selectionChanged()
    }
    func saveNotes() {
        💾ICloud.save(self.📚notes)
        self.🗑trash.save()
    }
    func reloadNotes() {
        guard let ⓝotes = 💾ICloud.loadNotes() else { return }
        self.📚notes = ⓝotes
    }
    func handleLeavingApp(_ ⓞldPhase: ScenePhase, _ ⓝewPhase: ScenePhase) {
        if ⓞldPhase == .active, ⓝewPhase == .inactive {
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

extension 📱AppModel {
    @objc
    @MainActor
    func iCloudDidChange(_ notification: Notification) {
        Task { @MainActor in
            if let ⓝewNotes = 💾ICloud.loadNotes() {
                self.🗑trash.storeDeletedNotes(self.📚notes.filter { !ⓝewNotes.contains($0) })
                self.📚notes = ⓝewNotes
            }
            print("🖨️ notification: ", notification.debugDescription)
        }
    }
    func forwardFromUserDefaults_1_1_2() {
        guard let ⓝotesVer_1_1_2: 📚Notes = 💾UserDefaults.loadNotesOfVer_1_1_2() else { return }
        self.📚notes.insert(contentsOf: ⓝotesVer_1_1_2.filter { !self.📚notes.contains($0) },
                            at: 0)
        🗑trash.storeDeletedNotes(ⓝotesVer_1_1_2)
        💾UserDefaults.clearNotesOfVer_1_1_2()
        💾ICloud.save(self.📚notes)
    }
}
