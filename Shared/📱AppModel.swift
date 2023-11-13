import SwiftUI
import WidgetKit

//MARK: Initializer, Stored property
@MainActor
class 📱AppModel: ObservableObject {
    @Published var notes: 📚Notes = .load() ?? []
    @Published var createdNewNoteID: UUID? = nil
    @Published var presentedSheetOnContentView: 📰SheetOnContentView? = nil
    @Published var trash: 🗑TrashModel = .load()
    @AppStorage("RandomMode", store: .ⓐppGroup) var randomMode: Bool = false
#if os(iOS)
    @Published var selectedTab: 🔖Tab = .notesList
    @Published var selectedSidebar: 🔖Sidebar? = .notesList
    @Published var presentedSheetOnWidgetSheet: 📰SheetOnWidgetSheet? = nil
    @AppStorage("separator", store: .ⓐppGroup) var separator: 📚TextConvert.Separator = .tab
    let inAppPurchaseModel = 🛒InAppPurchaseModel(id: "MemorizeWidget.adfree")
#endif
    init() {
        self.forwardFromUserDefaults_1_1_2()
        self.setPlaceholder()
        self.notes.cleanEmptyTitleNotes()
        self.trash.cleanExceededContents()
        🩹WorkaroundOnIOS15.SyncWidget.save(self.notes)
        💾ICloud.addObserver(self, #selector(self.iCloudDidChangeExternally(_:)))
    }
}

//MARK: Computed property, Method
extension 📱AppModel {
    func deleteNoteOnNotesList(_ ⓘndexSet: IndexSet) {
        guard let ⓘndex = ⓘndexSet.first else { return }
        self.trash.storeDeletedNotes([self.notes[ⓘndex]])
        self.notes.remove(atOffsets: ⓘndexSet)
        self.saveNotes()
    }
    func moveNote(_ ⓢource: IndexSet, _ ⓓestination: Int) {
        self.notes.move(fromOffsets: ⓢource, toOffset: ⓓestination)
        self.saveNotes()
    }
    private func addNewNote(index ⓘndex: Int) {
        let ⓝewNote: 📗Note = .empty
        self.notes.insert(ⓝewNote, at: ⓘndex)
        self.createdNewNoteID = ⓝewNote.id
        💥Feedback.light()
    }
    func addNewNoteOnTop() {
        self.addNewNote(index: 0)
    }
    func addNewNoteBelow(_ ⓝote: 📗Note) {
        guard let ⓘndex = self.notes.firstIndex(of: ⓝote) else { return }
        self.addNewNote(index: ⓘndex + 1)
    }
    func moveTop(_ ⓝote: 📗Note) {
        guard let ⓘndex = self.notes.firstIndex(of: ⓝote) else { return }
        self.notes.move(fromOffsets: [ⓘndex], toOffset: 0)
        self.saveNotes()
        💥Feedback.light()
    }
    func moveEnd(_ ⓝote: 📗Note) {
        guard let ⓘndex = self.notes.firstIndex(of: ⓝote) else { return }
        self.notes.move(fromOffsets: [ⓘndex], toOffset: self.notes.endIndex)
        self.saveNotes()
        💥Feedback.light()
    }
    func removeNote(_ ⓝote: 📗Note, feedback ⓕeedback: Bool = true) {
        self.trash.storeDeletedNotes([ⓝote])
        withAnimation { self.notes.removeAll(where: { $0 == ⓝote }) }
        self.saveNotes()
        if ⓕeedback { 💥Feedback.warning() }
    }
    func removeNote(_ ⓘd: UUID) {
        guard let ⓝote = self.notes.first(where: { $0.id == ⓘd }) else { return }
        self.removeNote(ⓝote)
    }
    func apply(_ ⓘnputtedNote: 📗Note, target ⓣargetNote: 📗Note) {
        guard let ⓘndex = self.notes.firstIndex(of: ⓣargetNote) else { return }
        self.notes[ⓘndex].title = ⓘnputtedNote.title
        self.notes[ⓘndex].comment = ⓘnputtedNote.comment
        self.saveNotes()
    }
    func removeAllNotes() {
        self.trash.storeDeletedNotes(self.notes)
        self.notes.removeAll()
        self.saveNotes()
        💥Feedback.error()
    }
    func insertOnTop(_ ⓝotes: 📚Notes) {
        self.notes.insert(contentsOf: ⓝotes, at: 0)
        self.saveNotes()
    }
    func restore(_ ⓒontent: 🗑DeletedContent) {
        let ⓡestoredNotes = ⓒontent.notes.map { 📗Note($0.title, $0.comment) }
        self.insertOnTop(ⓡestoredNotes)
        self.trash.remove(ⓒontent)
        self.saveNotes()
        💥Feedback.light()
    }
    func saveNotes() {
        💾ICloud.save(self.notes)
        WidgetCenter.shared.reloadAllTimelines()
    }
}

//MARK: Handle widget URL
extension 📱AppModel {
    func handleWidgetURL(_ ⓤrl: URL) {
        self.presentedSheetOnContentView = nil
#if os(iOS)
        self.presentedSheetOnWidgetSheet = nil
#endif
        if let ⓣag = 🪧Tag.decode(ⓤrl) {
            switch ⓣag {
                case .notes(_):
                    if !ⓣag.targetedNoteIDs.isEmpty {
                        self.presentedSheetOnContentView = .widget(ⓣag)
                    } else {
                        break
                    }
                case .newNoteShortcut:
#if os(iOS)
                    self.addNewNoteByNewNoteShortcut()
#elseif os(watchOS)
                    self.presentedSheetOnContentView = .newNoteShortcut
#endif
                case .placeholder:
                    break
            }
            💥Feedback.light()
        } else {
            assertionFailure()
        }
#if os(iOS)
        self.switchNotesListTab()
        self.handleToPresentADSheet()
#endif
    }
}

//MARK: Others
extension 📱AppModel {
    func presentSheet(_ ⓣarget: 📰SheetOnContentView) {
        💥Feedback.light()
        self.presentedSheetOnContentView = ⓣarget
    }
    var openedWidgetNoteIDs: [UUID] {
        self.presentedSheetOnContentView?.widgetTag?.targetedNoteIDs ?? []
    }
    var openedWidgetSingleNoteIndex: Int? {
        self.notes.index(self.openedWidgetNoteIDs.first)
    }
    var openedWidgetNotesCount: Int {
        self.presentedSheetOnContentView?.widgetTag?.targetedNoteIDs.count ?? 0
    }
    var deletedAllWidgetNotes: Bool {
        guard case .widget(let ⓣag) = self.presentedSheetOnContentView else {
            return false
        }
        return ⓣag.targetedNoteIDs.allSatisfy { ⓘd in
            !self.notes.contains { $0.id == ⓘd }
        }
    }
    var exceedDataSizePerhaps: Bool {
        self.notes.dataCount > 800000
    }
}

//MARK: iCloud
extension 📱AppModel {
    @objc
    func iCloudDidChangeExternally(_ notification: Notification) {
        Task { @MainActor in
            if let ⓝewNotes = 💾ICloud.loadNotes() {
                self.trash.storeDeletedNotes(self.notes.filter { !ⓝewNotes.contains($0) })
                self.notes = ⓝewNotes
                🩹WorkaroundOnIOS15.SyncWidget.save(ⓝewNotes)
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
}

//MARK: Migration ver 1.1.2
extension 📱AppModel {
    func forwardFromUserDefaults_1_1_2() {
        guard let ⓝotesVer_1_1_2 = 💾UserDefaults.loadNotesOfVer_1_1_2() else { return }
        self.insertOnTop(ⓝotesVer_1_1_2)
        trash.storeDeletedNotes(ⓝotesVer_1_1_2)
        💾UserDefaults.clearNotesOfVer_1_1_2()
    }
    func setPlaceholder() {
        if self.notes.isEmpty, 💾ICloud.notesIsNil, 💾UserDefaults.notesVer_1_1_2_IsNil {
            self.notes = .placeholder
        }
    }
}
