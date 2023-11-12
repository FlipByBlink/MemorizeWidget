import SwiftUI

enum 🔖Tab {
    case notesList, menu, trash, guide, app
}

extension 🔖Tab: CaseIterable, Identifiable {
    var id: Self { self }
    var title: LocalizedStringKey {
        switch self {
            case .notesList: "Notes"
            case .menu: "Menu"
            case .trash: "Trash"
            case .guide: "Guide"
            case .app: "App"
        }
    }
    var iconName: String {
        switch self {
            case .notesList: "text.justify.leading"
            case .menu: "gearshape"
            case .trash: "trash"
            case .guide: "questionmark"
            case .app: "info"
        }
    }
    func bottomBarLabel() -> some View {
        Label(self.title, systemImage: self.iconName)
    }
    var sidebarLabel: some View {
        Label(self.title, systemImage: self.iconName)
    }
    var detailView: Self.DetailView { .init(selectedTab: self) }
    struct DetailView: View {
        var selectedTab: 🔖Tab
        var body: some View {
            Group {
                switch self.selectedTab {
                    case .notesList: 📚NotesListTab()
                    case .menu: 🔩MenuTab()
                    case .trash: 🗑TrashTab()
                    case .guide: 💁GuideTab()
                    case .app: ℹ️AboutAppTab()
                }
            }
            .tag(self.selectedTab)
            .tabItem(self.selectedTab.bottomBarLabel)
        }
    }
}
