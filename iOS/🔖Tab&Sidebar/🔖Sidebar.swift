import SwiftUI

enum 🔖Sidebar {
    case notesList
    case option
    case trash
    case guide
}

extension 🔖Sidebar: CaseIterable, Identifiable {
    var id: Self { self }
    func navigationLink() -> some View {
        NavigationLink(value: self) {
            Label(self.title, systemImage: self.iconName)
        }
        //よく分からないがサンプルコードではNavigationLinkで実装してる例あり。
        //Label(self.title, systemImage: self.iconName) ← これとの差異がよく分からない。
    }
    var detailView: some View {
        Self.DetailView(selectedTab: self)
    }
}

private extension 🔖Sidebar {
    private var title: LocalizedStringKey {
        switch self {
            case .notesList: "Notes"
            case .option: "Option"
            case .trash: "Trash"
            case .guide: "Guide"
        }
    }
    private var iconName: String {
        switch self {
            case .notesList: "text.justify.leading"
            case .option: "gearshape"
            case .trash: "trash"
            case .guide: "questionmark"
        }
    }
    private struct DetailView: View {
        var selectedTab: 🔖Sidebar
        var body: some View {
            switch self.selectedTab {
                case .notesList: 📚NotesListTab()
                case .option: 🎛️OptionTab()
                case .trash: 🗑TrashTab()
                case .guide: 💁GuideTab()
            }
        }
    }
}
