import SwiftUI

enum 🗒️StaticInfo {
    static let appName: LocalizedStringKey = "MemorizeWidget"
    static let appSubTitle: LocalizedStringKey = "App for iPhone / iPad / Mac / Apple Watch"
    
    static let appStoreProductURL = URL(string: "https://apps.apple.com/app/id1644276262")!
    static var appStoreUserReviewURL: URL { .init(string: "\(Self.appStoreProductURL)?action=write-review")! }
    
    static var contactAddress: String { "sear_pandora_0x@icloud.com" }
    
    static let privacyPolicyDescription = """
        2022-09-08
        
        (English) This application don't collect user infomation.
        
        (Japanese) このアプリ自身において、ユーザーの情報を一切収集しません。
        """
    
    static let webRepositoryURL = URL(string: "https://github.com/FlipByBlink/MemorizeWidget")!
    static let webMirrorRepositoryURL = URL(string: "https://gitlab.com/FlipByBlink/MemorizeWidget_Mirror")!
}

#if os(iOS)
extension 🗒️StaticInfo {
    static let versionInfos: [(version: String, date: String)] = [("1.4", "2023-11-16(temporary)"),
                                                                  ("1.3", "2023-09-14"),
                                                                  ("1.2.1", "2023-05-24"),
                                                                  ("1.2", "2023-04-14"),
                                                                  ("1.1.2", "2022-12-05"),
                                                                  ("1.1.1", "2022-12-01"),
                                                                  ("1.1", "2022-10-30"),
                                                                  ("1.0.2", "2022-09-16"),
                                                                  ("1.0.1", "2022-09-11"),
                                                                  ("1.0", "2022-09-09")] //降順。先頭の方が新しい
    
    enum SourceCodeCategory: String, CaseIterable, Identifiable {
        case main, Rest, Widget, ShareExtension
        var id: Self { self }
        var fileNames: [String] {
            switch self {
                case .main: ["App.swift",
                             "ContentView.swift",
                             "📱AppModel.swift",
                             "📗NoteModel.swift"]
                case .Rest: ["💾ICloud.swift",
                             "📗NoteView.swift",
                             "📚NotesListTab.swift",
                             "📖WidgetNotesSheet.swift",
                             "📘Dictionary.swift",
                             "🔍SearchButton.swift",
                             "🚮DeleteNoteButton.swift",
                             "🗑TrashModel.swift",
                             "🗑TrashTab.swift",
                             "📥NotesImportSheet.swift",
                             "🔩MenuTab.swift",
                             "🆕NewNoteCommand.swift",
                             "💥Feedback.swift",
                             "💁GuideTab.swift",
                             "🩹Workaround.swift",
                             "💾UserDefaults.swift",
                             "🗒️StaticInfo.swift",
                             "💬RequestUserReview.swift",
                             "ℹ️AboutAppTab.swift",
                             "ℹ️AboutApp.swift",
                             "📣ADSheet.swift",
                             "📣ADModel.swift",
                             "📣ADComponents.swift",
                             "🛒InAppPurchaseModel.swift",
                             "🛒InAppPurchaseView.swift"]
                case .Widget: ["Widget.swift",
                               "🪧WidgetState.swift",
                               "🪧WidgetInfo.swift",
                               "🪧WidgetEntry.swift",
                               "🪧Provider.swift",
                               "🪧EntryView.swift",
                               "🪧SystemWidgetView.swift",
                               "🪧AccessoryWidgetView.swift",
                               "🪧NoNoteView.swift",
                               "🪧NewNoteShortcutWidget.swift",
                               "🪧MultiNotesCount.swift",
                               "🪧ContainerBackground.swift"]
                case .ShareExtension: ["🄷ostingViewController.swift",
                                       "📨ShareExtensionModel.swift"]
            }
        }
    }
}

#elseif os(watchOS)
extension 🗒️StaticInfo {
    enum SourceCodeCategory: String, CaseIterable, Identifiable {
        case main, Rest, Widget
        var id: Self { self }
        var fileNames: [String] {
            switch self {
                case .main: ["App.swift",
                             "ContentView.swift",
                             "📱AppModel.swift",
                             "📗NoteModel.swift"]
                case .Rest: ["📖WidgetNotesSheet.swift",
                             "📗NoteView.swift",
                             "📚NotesMenu.swift",
                             "🔩MainMenu.swift",
                             "🗑TrashMenu.swift",
                             "💁TipsMenu.swift",
                             "🆕NewNoteShortcut.swift",
                             "💥Feedback.swift",
                             "💾ICloud.swift",
                             "💾UserDefaults.swift",
                             "🗑TrashModel.swift",
                             "🗒️StaticInfo.swift",
                             "ℹ️AboutApp.swift"]
                case .Widget: ["Widget.swift",
                               "🪧WidgetState.swift",
                               "🪧WidgetInfo.swift",
                               "🪧WidgetEntry.swift",
                               "🪧Provider.swift",
                               "🪧EntryView.swift",
                               "🪧NewNoteShortcutWidget.swift",
                               "🪧MultiNotesCount.swift",
                               "🪧ContainerBackground.swift",
                               "🪧AccessoryWidgetView.swift"]
            }
        }
    }
}
#endif
