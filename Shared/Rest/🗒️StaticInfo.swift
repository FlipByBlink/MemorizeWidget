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
    static let versionInfos: [(version: String, date: String)] = [
        ("1.4", "2023-11-28"),
        ("1.3", "2023-09-14"),
        ("1.2.1", "2023-05-24"),
        ("1.2", "2023-04-14"),
        ("1.1.2", "2022-12-05"),
        ("1.1.1", "2022-12-01"),
        ("1.1", "2022-10-30"),
        ("1.0.2", "2022-09-16"),
        ("1.0.1", "2022-09-11"),
        ("1.0", "2022-09-09")
    ] //降順。先頭の方が新しい
    
    enum SourceCodeCategory: String, CaseIterable, Identifiable {
        case main
        case AppModel
        case RootView
        case TabAndSidebar
        case NoteModel
        case NoteView
        case NotesListTab
        case WidgetSheet
        case Sheet
        case Option
        case Data
        case Search
        case Import
        case Trash
        case Rest
        case Widget
        case ShareExtension
        var id: Self { self }
        var fileNames: [String] {
            switch self {
                case .main: [
                    "App.swift",
                    "ContentView.swift"
                ]
                case .AppModel: [
                    "📱AppModel.swift",
                    "📱AppModel(extension).swift",
                ]
                case .RootView: [
                    "🏢RootView.swift",
                    "🏢IPadView.swift",
                ]
                case .TabAndSidebar: [
                    "🔖Tab.swift",
                    "🔖TabView.swift",
                    "🔖Sidebar.swift",
                    "🔖SidebarView.swift",
                ]
                case .NoteModel: [
                    "📗Note.swift",
                    "📚Notes.swift",
                    "📚TextConvert.swift"
                ]
                case .NoteView: [
                    "📗NoteView.swift",
                    "📗Placement.swift",
                    "FocusedValues(extension).swift",
                ]
                case .NotesListTab: [
                    "📚NotesListTab.swift",
                    "📚SubButtons.swift",
                    "📚NotesMenuButton.swift",
                    "📚DisableInEditMode.swift",
                ]
                case .WidgetSheet: [
                    "📖WidgetSheetView.swift",
                    "📖SingleNoteLayoutView.swift",
                    "📖MultiNotesLayoutView.swift",
                    "📖DeletedNoteView.swift",
                    "📖DictionaryButton.swift",
                    "📖SearchButton.swift",
                    "📖MoveEndButton.swift",
                    "📖DismissWidgetSheetOnBackground.swift",
                ]
                case .Sheet: [
                    "📰SheetOnContentView.swift",
                    "📰SheetHandlerOnContentView.swift",
                    "📰SheetOnWidgetSheet.swift",
                    "📰DismissButton.swift",
                ]
                case .Option: [
                    "🎛️Option.swift",
                    "🎛️Key.swift",
                    "🎛️Default.swift",
                    "🎛️MultilineTextAlignment.swift",
                    "🎛️ViewComponent.swift",
                    "🎛️RandomModeToggle.swift",
                    "🎛️OptionTab.swift",
                    "🎛️MultiNotesOnWidgetOption.swift",
                    "🎛️CommentOnWidgetOption.swift",
                    "🎛️BeforeAfterImages.swift",
                    "🎛️FontSizeOptionMenu.swift",
                ]
                case .Data: [
                    "💾ICloud.swift",
                    "💾UserDefaults.swift",
                    "UserDefaults(extension).swift",
                    "🩹WorkaroundOnIOS15.swift",
                ]
                case .Search: [
                    "🔍SearchModel.swift",
                    "🔍FailureAlert.swift",
                    "🔍SearchSheetView.swift",
                    "🔍CustomizeSearchMenu.swift",
                ]
                case .Import: [
                    "📥NotesImportModel.swift",
                    "📥Error.swift",
                    "📥SeparatorPicker.swift",
                    "📥InputMode.swift",
                    "📥NotesImportSheetView.swift",
                    "📥ConvertedNotesMenu.swift",
                    "📥FileImportSection.swift",
                    "📥TextImportSection.swift",
                    "📥InputExample.swift",
                    "📥NotesImportSheetButton.swift",
                ]
                case .Trash: [
                    "🗑TrashViewComponent.swift",
                    "🗑TrashModel.swift",
                    "🗑DeletedContent.swift",
                    "🗑TrashTab.swift",
                ]
                case .Rest: [
                    "📤NotesExportSheetView.swift",
                    "🚮DeleteNoteButton.swift",
                    "🚮DeleteAllNotesButton.swift",
                    "📘DictionarySheetView.swift",
                    "🆕NewNoteCommand.swift",
                    "💥Feedback.swift",
                    "🩹Workaround.swift",
                    "💁GuideTab.swift",
                    "💁GuideViewComponent.swift",
                    "💬RequestUserReview.swift",
                    "ℹ️AboutAppTab.swift",
                    "ℹ️AboutApp.swift",
                    "📣ADModel.swift",
                    "📣ADContentView.swift",
                    "📣ADComponents.swift",
                    "🛒InAppPurchaseModel.swift",
                    "🛒InAppPurchaseView.swift",
                    "🗒️StaticInfo.swift",
                ]
                case .Widget: [
                    "WidgetBundle.swift",
                    "🪧PrimaryWidget.swift",
                    "🪧SubWidget.swift",
                    "🪧Provider.swift",
                    "🪧Entry.swift",
                    "🪧Kind.swift",
                    "🪧Phase.swift",
                    "🪧Tag.swift",
                    "🪧EntryView.swift",
                    "🪧SystemWidgetView.swift",
                    "🪧AccessoryWidgetView.swift",
                    "🪧NewNoteShortcutWidget.swift",
                    "🪧NoNoteView.swift",
                    "🪧PlaceholderView.swift",
                    "🪧ContainerBackground.swift",
                ]
                case .ShareExtension: [
                    "📨ShareExtensionModel.swift",
                    "📨HostingViewController.swift",
                    "📨RootView.swift",
                    "📨InputType.swift",
                ]
            }
        }
    }
}

#elseif os(watchOS)
extension 🗒️StaticInfo {
    enum SourceCodeCategory: String, CaseIterable, Identifiable {
        case main
        case AppModel
        case Note
        case Sheet
        case Option
        case Data
        case Trash
        case Rest
        case Widget
        var id: Self { self }
        var fileNames: [String] {
            switch self {
                case .main: [
                    "App.swift",
                    "ContentView.swift"
                ]
                case .AppModel: [
                    "📱AppModel.swift",
                    "📱AppModel(extension).swift",
                ]
                case .Note: [
                    "📗Note.swift",
                    "📚Notes.swift",
                    "📗NoteView.swift",
                    "📚NotesListMenu.swift",
                ]
                case .Sheet: [
                    "📰SheetOnContentView.swift",
                    "📰SheetHandlerOnContentView.swift",
                    "📖WidgetSheetView.swift",
                ]
                case .Option: [
                    "🎛️Option.swift",
                    "🎛️Key.swift",
                    "🎛️Default.swift",
                    "🎛️MultilineTextAlignment.swift",
                    "🎛️ViewComponent.swift",
                    "🎛️RandomModeToggle.swift",
                    "🎛️FontSizeMenu.swift",
                ]
                case .Data: [
                    "💾ICloud.swift",
                    "💾UserDefaults.swift",
                    "UserDefaults(extension).swift",
                    "🩹WorkaroundOnIOS15.swift",
                ]
                case .Trash: [
                    "🗑TrashViewComponent.swift",
                    "🗑TrashModel.swift",
                    "🗑DeletedContent.swift",
                    "🗑TrashMenu.swift",
                ]
                case .Rest: [
                    "🔩MainMenu.swift",
                    "🚮DeleteAllNotesButton.swift",
                    "🆕NewNoteShortcut.swift",
                    "💥Feedback.swift",
                    "💁GuideMenu.swift",
                    "💁GuideViewComponent.swift",
                    "ℹ️AboutApp.swift",
                    "🗒️StaticInfo.swift",
                ]
                case .Widget: [
                    "WidgetBundle.swift",
                    "🪧PrimaryWidget.swift",
                    "🪧SubWidget.swift",
                    "🪧Provider.swift",
                    "🪧Entry.swift",
                    "🪧Kind.swift",
                    "🪧Phase.swift",
                    "🪧Tag.swift",
                    "🪧EntryView.swift",
                    "🪧AccessoryWidgetView.swift",
                    "🪧NewNoteShortcutWidget.swift",
                    "🪧NoNoteView.swift",
                    "🪧PlaceholderView.swift",
                    "🪧ContainerBackground.swift",
                ]
            }
        }
    }
}

#elseif os(macOS)
extension 🗒️StaticInfo {
    static let versionInfos: [(version: String, date: String)] = [
        ("1.4", "2023-11-28"),
        ("1.3", "2023-09-14"),
        ("1.2.1", "2023-05-24"),
        ("1.2", "2023-04-14"),
    ] //降順。先頭の方が新しい
    enum SourceCodeCategory: String, CaseIterable, Identifiable {
        case main
        case AppModel
        case NoteModel
        case NotesWindow
        case WidgetSheet
        case Data
        case Option
        case Settings
        case Search
        case Import
        case Trash
        case MenuBarShortcut
        case Widget
        case Rest
        var id: Self { self }
        var fileNames: [String] {
            switch self {
                case .main: [
                    "App.swift"
                ]
                case .AppModel: [
                    "📱AppModel.swift",
                    "📱AppModel(extension).swift",
                    "📱AppModel(NSApplicationDelegate).swift"
                ]
                case .NoteModel: [
                    "📗Note.swift",
                    "📚Notes.swift",
                    "📚TextConvert.swift"
                ]
                case .NotesWindow: [
                    "📚NotesWindow.swift",
                    "📚ContentView.swift",
                    "📚NotesList.swift",
                    "📗NoteRow.swift",
                    "🚏ContextMenu.swift",
                    "🔝NewNoteOnTopButton.swift",
                    "🛫MoveTopButton.swift",
                    "🛬MoveEndButton.swift",
                    "👆InsertAboveButton.swift",
                    "👇InsertBelowButton.swift",
                    "📘DictionaryButton.swift",
                    "🔍SearchButton.swift",
                    "📰SheetHandlerOnContentView.swift",
                    "🪄Commands.swift",
                    "🔦FocusedModelHandler.swift",
                    "FocusedValues(extension).swift",
                ]
                case .WidgetSheet: [
                    "📖WidgetSheetView.swift",
                    "📖NoteRow.swift",
                    "📖DeletedNoteView.swift",
                    "📖MoveEndButton.swift",
                    "📖SheetDebug.swift",
                ]
                case .Data: [
                    "💾ICloud.swift",
                    "💾UserDefaults.swift",
                    "UserDefaults(extension).swift",
                    "🩹WorkaroundOnIOS15.swift",
                ]
                case .Option: [
                    "🎛️Option.swift",
                    "🎛️Key.swift",
                    "🎛️Default.swift",
                    "🎛️MultilineTextAlignment.swift",
                    "🎛️ViewComponent.swift",
                    "🎛️RandomModeToggle.swift",
                ]
                case .Settings: [
                    "🔧Settings.swift",
                    "🔧WidgetPanel.swift",
                    "🔧MenuBarPanel.swift",
                    "🔧SearchCustomizePanel.swift",
                    "🔧GuidePanel.swift",
                ]
                case .Search: [
                    "🔍SearchModel.swift",
                    "🔍FailureAlert.swift",
                ]
                case .Import: [
                    "📥NotesImportModel.swift",
                    "📥Error.swift",
                    "📥SeparatorPicker.swift",
                    "📥NotesImportTextSheetView.swift",
                    "📥NotesImportFileSheetView.swift",
                    "📥ConvertedNotesMenu.swift",
                    "📥DismissButton.swift",
                    "📥NotSupportMultiLineTextInNoteSection.swift",
                ]
                case .Trash: [
                    "🗑TrashViewComponent.swift",
                    "🗑TrashModel.swift",
                    "🗑DeletedContent.swift",
                    "🗑TrashWindow.swift",
                    "🗑ContentView.swift",
                ]
                case .MenuBarShortcut: [
                    "🏗️MenuBarShortcut.swift",
                    "🏗️ContentView.swift",
                ]
                case .Widget: [
                    "WidgetBundle.swift",
                    "🪧PrimaryWidget.swift",
                    "🪧SubWidget.swift",
                    "🪧Provider.swift",
                    "🪧Entry.swift",
                    "🪧Kind.swift",
                    "🪧Phase.swift",
                    "🪧Tag.swift",
                    "🪧EntryView.swift",
                    "🪧SystemWidgetView.swift",
                    "🪧NoNoteView.swift",
                    "🪧PlaceholderView.swift",
                    "🪧ContainerBackground.swift",
                ]
                case .Rest: [
                    "📤NotesExportSheetView.swift",
                    "💬RequestUserReview.swift",
                    "📣ADSheet.swift",
                    "📣ADContent.swift",
                    "ℹ️HelpWindows.swift",
                    "ℹ️HelpCommands.swift",
                    "🛒InAppPurchaseWindow.swift",
                    "🛒InAppPurchaseMenu.swift",
                    "🛒InAppPurchaseCommand.swift",
                ]
            }
        }
    }
}
#endif
