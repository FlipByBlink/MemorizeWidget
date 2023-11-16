import SwiftUI

enum 🔖Tab {
    case notesList
    case option
    case trash
    case guide
    case app
}

extension 🔖Tab: CaseIterable, Identifiable {
    var id: Self { self }
    func label() -> some View {
        Label(self.title, systemImage: self.iconName)
    }
    var detailView: some View {
        Self.DetailView(selectedTab: self)
    }
}

private extension 🔖Tab {
    private var title: LocalizedStringKey {
        switch self {
            case .notesList: "Notes"
            case .option: "Option"
            case .trash: "Trash"
            case .guide: "Guide"
            case .app: "App"
        }
    }
    private var iconName: String {
        switch self {
            case .notesList: "text.justify.leading"
            case .option: "gearshape"
            case .trash: "trash"
            case .guide: "questionmark"
            case .app: "info"
        }
    }
    private struct DetailView: View {
        var selectedTab: 🔖Tab
        var body: some View {
            Group {
                switch self.selectedTab {
                    case .notesList: 📚NotesListTab()
                    case .option: 🎛️OptionTab()
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
