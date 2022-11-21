
import SwiftUI
import WidgetKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🔖tab: 🔖Tab = .notesList
    var body: some View {
        TabView(selection: $🔖tab) {
            📚NotesListTab()
                .tag(🔖Tab.notesList)
                .tabItem { Label("Notes", systemImage: "text.justify.leading") }
            🔩OptionTab()
                .tag(🔖Tab.option)
                .tabItem { Label("Option", systemImage: "gearshape") }
            🛒PurchaseTab()
                .tag(🔖Tab.purchase)
                .tabItem { Label("Purchase", systemImage: "cart") }
            ℹ️AboutAppTab()
                .tag(🔖Tab.about)
                .tabItem { Label("About App", systemImage: "questionmark") }
        }
        .onOpenURL { 🔗 in
            if 🔗.description == "NewNoteShortcut" {
                📱.🚩showImportSheet = false
                📱.🚩showNoteSheet = false
            }
            if 📱.📚notes.contains(where: { $0.id.description == 🔗.description }) {
                📱.🚩showImportSheet = false
                📱.🚩showNoteSheet = true
                📱.🆔openedNoteID = 🔗.description
            }
            🔖tab = .notesList
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
        .sheet(isPresented: $📱.🚩showNoteSheet) {
            🪧NoteSheet()
        }
        .sheet(isPresented: $📱.🚩showImportSheet) {
            📂FileImportSheet()
        }
        .modifier(🪄ReloadWidgetOnSceneChange())
        .modifier(💾OperateData())
    }
    enum 🔖Tab {
        case notesList, option, purchase, about
    }
}

struct 📚NotesListTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationView {
            List {
                🚩RandomModeSection()
                🆕NewNoteButton()
                ForEach($📱.📚notes) { ⓝote in
                    📓NoteRow(ⓝote)
                }
                .onDelete { 📱.📚notes.remove(atOffsets: $0) }
                .onMove { 📱.📚notes.move(fromOffsets: $0, toOffset: $1) }
            }
            .navigationBarTitleDisplayMode(.inline)
            .animation(.default, value: 📱.📚notes)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .disabled(📱.📚notes.isEmpty)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        UISelectionFeedbackGenerator().selectionChanged()
                        📱.🚩showImportSheet.toggle()
                    } label: {
                        Label("Import notes", systemImage: "tray.and.arrow.down")
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    struct 🚩RandomModeSection: View {
        @AppStorage("RandomMode", store: UserDefaults(suiteName: 🆔AppGroupID)) var 🚩randomMode: Bool = false
        var body: some View {
            Section {
                Toggle(isOn: $🚩randomMode) {
                    Label("Random mode", systemImage: "shuffle")
                        .padding(.vertical, 8)
                }
                .onChange(of: 🚩randomMode) { _ in
                    WidgetCenter.shared.reloadAllTimelines()
                }
            } footer: {
                Text("Change the note per 5 minutes.")
            }
        }
    }
    func 🆕NewNoteButton() -> some View {
        Button {
            📱.🆕addNewNote()
        } label: {
            Label("New note", systemImage: "plus")
                .font(.title3.weight(.semibold))
                .padding(.vertical, 7)
        }
        .onOpenURL { 🔗 in
            if 🔗.description == "NewNoteShortcut" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    📱.🆕addNewNote()
                }
            }
        }
    }
    struct 📓NoteRow: View {
        @EnvironmentObject var 📱: 📱AppModel
        @AppStorage("RandomMode", store: UserDefaults(suiteName: 🆔AppGroupID)) var 🚩randomMode: Bool = false
        @FocusState private var 🔍Focus: 🄵ocusPattern?
        @Binding var ⓝote: 📗Note
        var 🎨Thin: Bool { !🚩randomMode && 📱.📚notes.first != ⓝote }
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    TextField("+ title", text: $ⓝote.title)
                        .focused($🔍Focus, equals: .title)
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(🎨Thin ? .tertiary : .primary)
                    TextField("+ comment", text: $ⓝote.comment)
                        .focused($🔍Focus, equals: .comment)
                        .font(.title3.weight(.light))
                        .foregroundStyle(🎨Thin ? .tertiary : .secondary)
                        .opacity(0.8)
                }
                .onSubmit { UISelectionFeedbackGenerator().selectionChanged() }
                .padding(8)
                .padding(.vertical, 6)
                .accessibilityHidden(!ⓝote.title.isEmpty)
                Menu {
                    Button {
                        📱.🆔openedNoteID = ⓝote.id.description
                        📱.🚩showNoteSheet = true
                        UISelectionFeedbackGenerator().selectionChanged()
                    } label: {
                        Label("Detail", systemImage: "doc.plaintext")
                    }
                    Button {
                        guard let ⓘndex = 📱.📚notes.firstIndex(of: ⓝote) else { return }
                        📱.🆕addNewNote(ⓘndex + 1)
                    } label: {
                        Label("New note", systemImage: "text.append")
                    }
                } label: {
                    Label("Menu", systemImage: "ellipsis.circle")
                        .labelStyle(.iconOnly)
                        .padding(.vertical, 8)
                        .padding(.trailing, 8)
                }
                .foregroundStyle(.secondary)
            }
            .onAppear {
                if ⓝote.title == "" {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                        🔍Focus = .title
                    }
                }
            }
            .onChange(of: 🔍Focus) { ⓝewValue in
                if ⓝewValue == nil {
                    if ⓝote.title == "" {
                        📱.📚notes.removeAll(where: { $0 == ⓝote })
                    }
                }
            }
        }
        enum 🄵ocusPattern {
            case title, comment
        }
        init(_ ⓝote: Binding<📗Note>) {
            self._ⓝote = ⓝote
        }
    }
}


struct 🪧NoteSheet: View {
    @EnvironmentObject var 📱: 📱AppModel
    @EnvironmentObject var 🛒: 🛒StoreModel
    @Environment(\.dismiss) var ﹀Dismiss: DismissAction
    @State private var 🚩ShowADMenuSheet: Bool = false
    @FocusState private var 🔍CommentFocus: Bool
    var 🔢NoteIndex: Int? {
        📱.📚notes.firstIndex { $0.id.uuidString == 📱.🆔openedNoteID }
    }
    var body: some View {
        NavigationView {
            GeometryReader { 📐 in
                VStack {
                    Spacer()
                    if let 🔢NoteIndex {
                        TextField("No title", text: $📱.📚notes[🔢NoteIndex].title)
                            .font(.title.bold())
                            .multilineTextAlignment(.center)
                            .accessibilityHidden(true)
                        TextEditor(text: $📱.📚notes[🔢NoteIndex].comment)
                            .focused($🔍CommentFocus)
                            .multilineTextAlignment(.center)
                            .font(.title3.weight(.light))
                            .foregroundStyle(.secondary)
                            .frame(minHeight: 50, maxHeight: 180)
                            .accessibilityHidden(true)
                            .overlay(alignment: .top) {
                                if 📱.📚notes[🔢NoteIndex].comment.isEmpty {
                                    Text("No comment")
                                        .foregroundStyle(.quaternary)
                                        .padding(6)
                                        .allowsHitTesting(false)
                                }
                            }
                            .overlay(alignment: .bottomTrailing) {
                                if 🔍CommentFocus {
                                    Button {
                                        🔍CommentFocus = false
                                        UISelectionFeedbackGenerator().selectionChanged()
                                    } label: {
                                        Label("Done", systemImage: "checkmark.circle.fill")
                                            .font(.largeTitle)
                                            .symbolRenderingMode(.hierarchical)
                                            .labelStyle(.iconOnly)
                                    }
                                    .foregroundStyle(.tertiary)
                                    .padding(8)
                                }
                            }
                        Spacer()
                        HStack(spacing: 36) {
                            Button(role: .destructive) {
                                📱.📚notes.remove(at: 🔢NoteIndex)
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            } label: {
                                Label("Delete", systemImage: "trash")
                                    .font(.title3.bold())
                                    .foregroundStyle(.secondary)
                                    .labelStyle(.iconOnly)
                            }
                            .tint(.red)
                            📗SystemDictionaryButton(🔢NoteIndex)
                                .font(.title3.weight(.semibold))
                                .foregroundStyle(.tertiary)
                            🔍SearchButton(🔢NoteIndex)
                                .font(.title3.weight(.semibold))
                                .foregroundStyle(.tertiary)
                        }
                        .padding()
                    } else {
                        HStack {
                            Spacer()
                            VStack(spacing: 24) {
                                Label("Deleted.", systemImage: "checkmark")
                                Image(systemName: "trash")
                            }
                            .imageScale(.small)
                            .font(.largeTitle)
                            .padding(.bottom, 48)
                            Spacer()
                        }
                    }
                    Spacer()
                    if 📐.size.height > 500 {
                        📣ADView(without: .MemorizeWidget, $🚩ShowADMenuSheet)
                            .frame(height: 160)
                    }
                }
                .modifier(📣ADMenuSheet($🚩ShowADMenuSheet))
                .animation(.default.speed(1.5), value: 🔢NoteIndex)
                .padding(24)
                .toolbar {
                    Button {
                        ﹀Dismiss.callAsFunction()
                        UISelectionFeedbackGenerator().selectionChanged()
                    } label: {
                        Image(systemName: "chevron.down")
                    }
                    .tint(.secondary)
                    .accessibilityLabel("Dismiss")
                }
            }
        }
    }
}


struct 🔩OptionTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationView {
            List {
                💬CommentOnWidgetSection()
                🔍CustomizeSearchSection()
                
                if #available(iOS 16.0, *) {
                    Section {
                        Text("If lock screen widgets don't update, please close this app or switch to another app.")
                    } header: {
                        Text("Directions")
                    }
                }
                
                💣DeleteAllNotesButton()
            }
            .navigationTitle("Option")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    struct 💬CommentOnWidgetSection: View {
        @AppStorage("ShowComment", store: UserDefaults(suiteName: 🆔AppGroupID)) var 🚩showComment: Bool = false//TODO: リファクタリング
        var body: some View {
            Section {
                Toggle(isOn: $🚩showComment) {
                    Label("Show comment on widget", systemImage: "text.append")
                        .padding(.vertical, 8)
                }
                .onChange(of: 🚩showComment) { _ in
                    WidgetCenter.shared.reloadAllTimelines()
                }
                VStack(spacing: 16) {
                    🏞BeforeAfterImage("homeSmall_commentOff", "homeSmall_commentOn")
                    if #available(iOS 16.0, *) {
                        🏞BeforeAfterImage("lockscreen_commentOff", "lockscreen_commentOn")
                    }
                }
                .padding()
                .frame(maxHeight: 500)
            }
        }
        func 🏞BeforeAfterImage(_ ⓑefore: String, _ ⓐfter: String) -> some View {
            HStack {
                Image(ⓑefore)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(16)
                    .shadow(radius: 2)
                    .rotationEffect(.degrees(1))
                Image(systemName: "arrow.right")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.secondary)
                Image(ⓐfter)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(16)
                    .shadow(radius: 2)
                    .rotationEffect(.degrees(1))
            }
        }
    }
    struct 🔍CustomizeSearchSection: View {
        @AppStorage("SearchLeadingText") var 🔗Leading: String = ""
        @AppStorage("SearchTrailingText") var 🔗Trailing: String = ""
        var body: some View {
            Section {
                VStack {
                    let ⓛeading = 🔗Leading.isEmpty ? "https://duckduckgo.com/?q=" : 🔗Leading
                    Text(ⓛeading + "NOTETITLE" + 🔗Trailing)
                        .italic()
                        .font(.system(.footnote, design: .monospaced))
                        .multilineTextAlignment(.center)
                        .padding(8)
                        .frame(minHeight: 100)
                        .animation(.default, value: 🔗Leading.isEmpty)
                    TextField("URL scheme", text: $🔗Leading)
                    TextField("Trailing component", text: $🔗Trailing)
                        .font(.caption)
                        .padding(.bottom, 4)
                }
                .textFieldStyle(.roundedBorder)
            } header: {
                Label("Customize search", systemImage: "magnifyingglass")
            }
            .headerProminence(.increased)
        }
    }
    func 💣DeleteAllNotesButton() -> some View {
        Menu {
            Button(role: .destructive) {
                📱.📚notes.removeAll()
                UINotificationFeedbackGenerator().notificationOccurred(.error)
            } label: {
                Label("OK, delete all notes.", systemImage: "trash")
            }
        } label: {
            ZStack {
                Color.clear
                Label("Delete all notes.", systemImage: "trash")
                    .foregroundColor(📱.📚notes.isEmpty ? nil : .red)
            }
        }
        .disabled(📱.📚notes.isEmpty)
    }
}


struct 🛒PurchaseTab: View {
    @EnvironmentObject var 🛒: 🛒StoreModel
    var body: some View {
        NavigationView { 📣ADMenu() }
            .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct ℹ️AboutAppTab: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                🄻istView()
                    .toolbar(.visible, for: .navigationBar)
            }
        } else {
            NavigationView { 🄻istView() }
                .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    func 🄻istView() -> some View {
        List {
            Section {
                ZStack {
                    Color.clear
                    VStack(spacing: 12) {
                        Image("ClipedIcon")
                            .resizable()
                            .shadow(radius: 4, y: 1)
                            .frame(width: 100, height: 100)
                        VStack(spacing: 6) {
                            Text("MemorizeWidget")
                                .font(.system(.title2, design: .rounded))
                                .fontWeight(.bold)
                                .tracking(1.5)
                                .opacity(0.75)
                                .lineLimit(1)
                                .minimumScaleFactor(0.1)
                            Text("Application for iPhone / iPad")
                                .font(.footnote)
                                .fontWeight(.medium)
                                .foregroundStyle(.secondary)
                        }
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                    }
                    .padding(48)
                }
            }
            Section {
                Link(destination: 🔗AppStoreProductURL) {
                    HStack {
                        Label("Open AppStore page", systemImage: "link")
                        Spacer()
                        Image(systemName: "arrow.up.forward.app")
                            .imageScale(.small)
                            .foregroundStyle(.secondary)
                    }
                }
                NavigationLink {
                    ℹ️AboutAppMenu()
                } label: {
                    Label("About App", systemImage: "doc")
                }
            }
        }
    }
}


struct 📂FileImportSheet: View {
    @EnvironmentObject var 📱: 📱AppModel
    @ObservedObject private var 🚛ImportProcess = 🚛ImportProcessModel()
    @AppStorage("InputMode") var ⓘnputMode: 🄸nputMode = .file
    @State private var 🚩ShowFileImporter: Bool = false
    @FocusState private var 🔍TextFieldFocus: Bool
    var body: some View {
        NavigationView {
            List {
                if 🚛ImportProcess.ⓞutputNotes.isEmpty {
                    Picker(selection: $ⓘnputMode) {
                        Label("File", systemImage: "doc").tag(🄸nputMode.file)
                        Label("Text", systemImage: "text.justify.left").tag(🄸nputMode.text)
                    } label: {
                        Label("Mode", systemImage: "tray.and.arrow.down")
                    }
                    Picker(selection: $🚛ImportProcess.ⓢeparator) {
                        Text("Tab ␣ ").tag(🅂eparator.tab)
                            .accessibilityLabel("Tab")
                        Text("Comma , ").tag(🅂eparator.comma)
                            .accessibilityLabel("Comma")
                        Text("(Title only)").tag(🅂eparator.titleOnly)
                            .accessibilityLabel("Title only")
                    } label: {
                        Label("Separator", systemImage: "arrowtriangle.left.and.line.vertical.and.arrowtriangle.right")
                    }
                    switch ⓘnputMode {
                        case .file:
                            Section {
                                Button {
                                    🚩ShowFileImporter.toggle()
                                } label: {
                                    Label("Import a text-encoded file", systemImage: "folder.badge.plus")
                                        .padding(.vertical, 8)
                                }
                            }
                            Section {
                                HStack {
                                    Image("sample_numbers")
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(12)
                                        .shadow(radius: 2)
                                    Image(systemName: "arrow.right")
                                        .font(.title2.weight(.semibold))
                                    Image("sample_importedNotes")
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(12)
                                        .shadow(radius: 2)
                                }
                                .frame(maxHeight: 220)
                                .padding(.horizontal, 8)
                                .padding(.vertical)
                                Image("numbers_csv_tsv_export")
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(12)
                                    .frame(maxHeight: 200)
                                    .shadow(radius: 2)
                                    .padding()
                                Image("sample_txt_macTextEdit")
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(12)
                                    .frame(maxHeight: 200)
                                    .shadow(radius: 2)
                                    .padding()
                            } header: {
                                Text("Example")
                            }
                        case .text:
                            Section {
                                TextEditor(text: $🚛ImportProcess.ⓘnputText)
                                    .focused($🔍TextFieldFocus)
                                    .font(.subheadline.monospaced())
                                    .frame(height: 100)
                                    .padding(8)
                                    .overlay {
                                        if 🚛ImportProcess.ⓘnputText.isEmpty {
                                            Label("Paste the text here.", systemImage: "square.and.pencil")
                                                .font(.subheadline)
                                                .rotationEffect(.degrees(2))
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.accentColor)
                                                .opacity(0.5)
                                                .allowsHitTesting(false)
                                        }
                                    }
                                    .toolbar {
                                        ToolbarItem(placement: .keyboard) {
                                            Button {
                                                🔍TextFieldFocus = false
                                            } label: {
                                                Label("Done", systemImage: "keyboard.chevron.compact.down")
                                            }
                                        }
                                    }
                                Button {
                                    🚛ImportProcess.convertTextToNotes()
                                } label: {
                                    Label("Convert this text to notes", systemImage: "text.badge.plus")
                                        .padding(.vertical, 8)
                                }
                                .disabled(🚛ImportProcess.ⓘnputText.isEmpty)
                            }
                            .animation(.default, value: 🚛ImportProcess.ⓘnputText.isEmpty)
                            Section {
                                HStack {
                                    Image("sample_appleNotes")
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(12)
                                        .shadow(radius: 2)
                                    Image(systemName: "arrow.right")
                                        .font(.title2.weight(.semibold))
                                    Image("sample_importedNotes")
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(12)
                                        .shadow(radius: 2)
                                }
                                .frame(maxHeight: 200)
                                .padding(.horizontal, 8)
                                .padding(.vertical)
                            } header: {
                                Text("Example")
                            }
                    }
                    🄽otSupportMultiLineTextInNote()
                } else {
                    ForEach(🚛ImportProcess.ⓞutputNotes) { ⓝote in
                        VStack(alignment: .leading) {
                            Text(ⓝote.title)
                            Text(ⓝote.comment)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if !🚛ImportProcess.ⓞutputNotes.isEmpty {
                        Button(role: .cancel) {
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            🚛ImportProcess.ⓞutputNotes = []
                        } label: {
                            Label("Cancel", systemImage: "xmark")
                                .font(.body.weight(.semibold))
                        }
                        .tint(.red)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !🚛ImportProcess.ⓞutputNotes.isEmpty {
                        Button {
                            📱.🚩showImportSheet = false
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                📱.📚notes.insert(contentsOf: 🚛ImportProcess.ⓞutputNotes, at: 0)
                                🚛ImportProcess.ⓞutputNotes = []
                            }
                        } label: {
                            Label("Done", systemImage: "checkmark")
                                .font(.body.weight(.semibold))
                        }
                    }
                }
                ToolbarItem(placement: .principal) {
                    Button {
                        📱.🚩showImportSheet = false
                        UISelectionFeedbackGenerator().selectionChanged()
                    } label: {
                        Image(systemName: "chevron.down")
                            .foregroundStyle(.quaternary)
                            .grayscale(1.0)
                            .padding(8)
                    }
                    .accessibilityLabel("Dismiss")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .animation(.default, value: 🚛ImportProcess.ⓞutputNotes)
        .animation(.default, value: ⓘnputMode)
        .fileImporter(isPresented: $🚩ShowFileImporter, allowedContentTypes: [.text]) { 📦Result in
            do {
                try 🚛ImportProcess.🄸mportFile(📦Result)
                🚛ImportProcess.convertTextToNotes()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func 🄽otSupportMultiLineTextInNote() -> some View {
        Section {
            Text("Not support multi line text in note.")
                .foregroundStyle(.secondary)
        } header: {
            Text("Directions")
        }
    }
    enum 🄸nputMode: String {
        case file, text
    }
}


struct 📗SystemDictionaryButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🚩ShowSystemDictionary: Bool = false
    var 🔢NoteIndex: Int
    var body: some View {
        Button {
            🚩ShowSystemDictionary = true
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
                .labelStyle(.iconOnly)
        }
        .sheet(isPresented: $🚩ShowSystemDictionary) {
            📗SystemDictionarySheet(term: 📱.📚notes[🔢NoteIndex].title)
        }
    }
    init(_ 🔢NoteIndex: Int) {
        self.🔢NoteIndex = 🔢NoteIndex
    }
    struct 📗SystemDictionarySheet: View {
        var ⓣerm: String
        var body: some View {
            🄳ictinaryView(term: ⓣerm)
                .ignoresSafeArea()
        }
        struct 🄳ictinaryView: UIViewControllerRepresentable {
            var ⓣerm: String
            func makeUIViewController(context: Context) ->  UIReferenceLibraryViewController {
                UIReferenceLibraryViewController(term: ⓣerm)
            }
            func updateUIViewController(_ uiViewController: UIReferenceLibraryViewController, context: Context) {}
            init(term: String) {
                ⓣerm = term
            }
        }
        init(term: String) {
            ⓣerm = term
        }
    }
}


struct 🔍SearchButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    @AppStorage("SearchLeadingText") var 🔗Leading: String = ""
    @AppStorage("SearchTrailingText") var 🔗Trailing: String = ""
    @Environment(\.openURL) var ⓞpenURL: OpenURLAction
    var 🔢NoteIndex: Int
    var body: some View {
        Button {
            let ⓛeading = 🔗Leading.isEmpty ? "https://duckduckgo.com/?q=" : 🔗Leading
            let ⓣext = ⓛeading + 📱.📚notes[🔢NoteIndex].title + 🔗Trailing
            guard let ⓔncodedText = ⓣext.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
            guard let ⓤrl = URL(string: ⓔncodedText) else { return }
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            ⓞpenURL.callAsFunction(ⓤrl)
        } label: {
            Label("Search", systemImage: "magnifyingglass")
                .labelStyle(.iconOnly)
        }
    }
    init(_ 🔢NoteIndex: Int) {
        self.🔢NoteIndex = 🔢NoteIndex
    }
}


struct 💾OperateData: ViewModifier {
    @EnvironmentObject var 📱: 📱AppModel
    @Environment(\.scenePhase) var 🚥phase: ScenePhase
    @State private var ⓛoadedNotes: [📗Note]? = 💾DataManager.notes
    private let 🕒timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    func body(content: Content) -> some View {
        content
            .onChange(of: 🚥phase) { [🚥phase] ⓝewValue in
                if 🚥phase != .active && ⓝewValue == .active {
                    if let ⓝotes = 💾DataManager.notes {
                        📱.📚notes = ⓝotes
                        ⓛoadedNotes = ⓝotes
                    }
                } else if 🚥phase == .active && ⓝewValue != .active {
                    💾DataManager.save(📱.📚notes)
                    WidgetCenter.shared.reloadAllTimelines()
                }
            }
            .onReceive(🕒timer) { _ in
                if 🚥phase == .active {
                    guard let ⓛatestDataNotes = 💾DataManager.notes else { return }
                    if ⓛoadedNotes != ⓛatestDataNotes {
                        📱.📚notes = ⓛatestDataNotes
                        ⓛoadedNotes = ⓛatestDataNotes
                    }
                }
            }
    }
}


struct 🪄ReloadWidgetOnSceneChange: ViewModifier {
    @Environment(\.scenePhase) var scenePhase: ScenePhase
    func body(content: Content) -> some View {
        content
            .onChange(of: scenePhase) { _ in
                WidgetCenter.shared.reloadAllTimelines()
            }
    }
}
