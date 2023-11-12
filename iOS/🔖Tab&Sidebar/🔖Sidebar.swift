import SwiftUI

enum 🔖Sidebar {
    case notesList, option, trash, guide
}

extension 🔖Sidebar: CaseIterable, Identifiable {
    var id: Self { self }
    var title: LocalizedStringKey {
        switch self {
            case .notesList: "Notes"
            case .option: "Option"
            case .trash: "Trash"
            case .guide: "Guide"
        }
    }
    var iconName: String {
        switch self {
            case .notesList: "text.justify.leading"
            case .option: "gearshape"
            case .trash: "trash"
            case .guide: "questionmark"
        }
    }
    var link: some View {
        NavigationLink(value: self) {
            Label(self.title, systemImage: self.iconName)
        }
        //よくわからないがサンプルコードではNavigationLinkで実装してたため、とりあえず実装
    }
    var detailView: Self.DetailView { .init(selectedTab: self) }
    struct DetailView: View {
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
