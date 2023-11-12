import SwiftUI

enum 🔖Tab {
    case notesList, option, trash, guide, app
}

extension 🔖Tab: CaseIterable, Identifiable {
    var id: Self { self }
    var title: LocalizedStringKey {
        switch self {
            case .notesList: "Notes"
            case .option: "Option"
            case .trash: "Trash"
            case .guide: "Guide"
            case .app: "App"
        }
    }
    var iconName: String {
        switch self {
            case .notesList: "text.justify.leading"
            case .option: "gearshape"
            case .trash: "trash"
            case .guide: "questionmark"
            case .app: "info"
        }
    }
    func label() -> some View {
        Label(self.title, systemImage: self.iconName)
    }
    var detailView: Self.DetailView { .init(selectedTab: self) }
    struct DetailView: View {
        var selectedTab: 🔖Tab
        var body: some View {
            Group {
                switch self.selectedTab {
                    case .notesList: NavigationStack { 📚NotesListTab() }
                    case .option: NavigationStack { 🎛️OptionTab() }
                    case .trash: 🗑TrashTab()
                    case .guide: 💁GuideTab()
                    case .app: ℹ️AboutAppTab()
                }
            }
            .tag(self.selectedTab)
            .tabItem(self.selectedTab.label)
        }
    }
}
