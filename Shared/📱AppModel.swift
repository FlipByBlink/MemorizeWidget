import SwiftUI
import WidgetKit

//MARK: Initializer, Stored property
@MainActor
final
class 📱AppModel: NSObject, ObservableObject {
    @Published var notes: 📚Notes = .load() ?? []
    @Published var createdNewNoteID: UUID? = nil
    @Published var presentedSheetOnContentView: 📰SheetOnContentView? = nil
    @Published var presentedAllNotesDeleteConfirmDialog: Bool = false
    @Published var trash: 🗑TrashModel = .load()
    @AppStorage(🎛️Key.randomMode, store: .ⓐppGroup) var randomMode: Bool = false
#if os(iOS)
    @Published var selectedTab: 🔖Tab = .notesList
    @Published var selectedSidebar: 🔖Sidebar? = .notesList
    @Published var presentedSheetOnWidgetSheet: 📰SheetOnWidgetSheet? = nil
#elseif os(macOS)
    @Published var notesSelection: Set<UUID> = []
#endif
#if os(iOS) || os(macOS)
    let inAppPurchaseModel = 🛒InAppPurchaseModel(id: "MemorizeWidget.adfree")
#endif
    override init() {
        super.init()
        self.forwardFromUserDefaults_1_1_2()
        self.setPlaceholder()
        self.notes.cleanEmptyTitleNotes()
        self.trash.cleanExceededContents()
        🩹WorkaroundOnIOS15.SyncWidget.save(self.notes)
        💾ICloud.addObserver(self, #selector(self.iCloudDidChangeExternally(_:)))
    }
}

//MARK: Handle notes
extension 📱AppModel {
    func moveNoteForDynamicView(_ ⓢource: IndexSet, _ ⓓestination: Int) {
        self.notes.move(fromOffsets: ⓢource, toOffset: ⓓestination)
        self.saveNotes()
    }
    var deleteNotesForDynamicView: Optional<(IndexSet) -> Void> {
        { ⓘndexSet in
            self.trash.storeDeletedNotes(ⓘndexSet.map { self.notes[$0] })
            self.notes.remove(atOffsets: ⓘndexSet)
            self.saveNotes()
#if os(watchOS)
            💥Feedback.warning()
#endif
        }
    }
    func addNewNote(index ⓘndex: Int) {
        let ⓝewNote: 📗Note = .empty
        self.notes.insert(ⓝewNote, at: ⓘndex)
        self.createdNewNoteID = ⓝewNote.id
        💥Feedback.light()
    }
    func addNewNoteOnTop() {
#if os(macOS)
        self.clearSelection()
#endif
        self.addNewNote(index: 0)
    }
#if os(iOS) || os(watchOS)
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
#endif
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
    func saveNotes(withWidgetReload ⓦidgetReload: Bool = true) {
        💾ICloud.save(self.notes)
        if ⓦidgetReload {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
#if os(iOS) || os(macOS)
    func submitNotesImport(_ ⓒonvertedNotes: 📚Notes) {
        self.insertOnTop(ⓒonvertedNotes)
        self.presentedSheetOnContentView = nil
        💥Feedback.success()
    }
#endif
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
                case .notes(let ⓘds):
                    if !ⓘds.isEmpty {
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
    var openedWidgetNoteIDs: [UUID] {
        if case .widget(let ⓣag) = self.presentedSheetOnContentView,
           case .notes(let ⓘds) = ⓣag {
            ⓘds
        } else {
            []
        }
    }
    var openedWidgetNotesCount: Int {
        self.openedWidgetNoteIDs.count
    }
    var exceedDataSizePerhaps: Bool {
        self.notes.dataCount > 800000
    }
#if os(iOS) || os(macOS)
    func presentSheetOnContentView(_ ⓣarget: 📰SheetOnContentView) {
        💥Feedback.light()
        self.presentedSheetOnContentView = ⓣarget
    }
#endif
#if os(iOS) || os(watchOS)
    var deletedAllWidgetNotes: Bool {
        if self.openedWidgetNoteIDs.count > 0 {
            self.openedWidgetNoteIDs.allSatisfy { ⓘd in
                !self.notes.contains { $0.id == ⓘd }
            }
        } else {
            false
        }
    }
#endif
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
        self.trash.storeDeletedNotes(ⓝotesVer_1_1_2)
        💾UserDefaults.clearNotesOfVer_1_1_2()
    }
    func setPlaceholder() {
        if self.notes.isEmpty, 💾ICloud.notesIsNil, 💾UserDefaults.notesVer_1_1_2_IsNil {
            self.notes = .placeholder
        }
    }
}
