import Foundation

let 📜versionInfos = 📜VersionInfo.history(("1.2", "2023-04-06"),
                                           ("1.1.2", "2022-12-05"),
                                           ("1.1.1", "2022-12-01"),
                                           ("1.1", "2022-10-30"),
                                           ("1.0.2", "2022-09-16"),
                                           ("1.0.1", "2022-09-11"),
                                           ("1.0", "2022-09-09")) //降順。先頭の方が新しい

let 🔗appStoreProductURL = URL(string: "https://apps.apple.com/app/id1644276262")!

let 👤privacyPolicyDescription = """
2022-09-08

(English) This application don't collect user infomation.

(Japanese) このアプリ自身において、ユーザーの情報を一切収集しません。
"""

let 🔗webRepositoryURL = URL(string: "https://github.com/FlipByBlink/MemorizeWidget")!
let 🔗webMirrorRepositoryURL = URL(string: "https://gitlab.com/FlipByBlink/MemorizeWidget_Mirror")!

enum 📁SourceCodeCategory: String, CaseIterable, Identifiable {
    case main, Shared, Sub, Others, WidgetExtension, ShareExtension, WatchApp, WatchComplication
    var id: Self { self }
    var fileNames: [String] {
        switch self {
            case .main:
                return ["MemorizeWidgetApp.swift",
                        "📱AppModel.swift",
                        "ContentView.swift",
                        "📗NoteModel.swift",
                        "🪧WidgetState.swift",
                        "💾UserDefaults.swift"]
            case .Shared:
                return []
            case .Sub:
                return ["📚NotesListTab.swift",
                        "📓NoteView.swift",
                        "📖WidgetNotesSheet.swift",
                        "🚮DeleteNoteButton.swift",
                        "🔩MenuTab.swift",
                        "📥NotesImportSheet.swift",
                        "📘Dictionary.swift",
                        "🔍SearchButton.swift",
                        "🗑Trash.swift",
                        "🗄️Rest.swift",
                        "💁GuideTab.swift",
                        "ℹ️AboutAppTab.swift"]
            case .Others:
                return ["🧰MetaData.swift",
                        "ℹ️AboutApp.swift",
                        "📣AD.swift",
                        "🛒InAppPurchase.swift"]
            case .WidgetExtension:
                return ["MWWidget.swift",
                        "🕒EntryView.swift",
                        "🆕NewNoteShortcutWidget.swift"]
            case .ShareExtension:
                return ["📨ShareExtensionModel.swift",
                        "🄷ostingViewController.swift"]
            case .WatchApp:
                return []
            case .WatchComplication:
                return []
        }
    }
}
