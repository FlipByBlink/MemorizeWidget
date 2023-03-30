import SwiftUI
import WidgetKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🔖tab: 🔖Tab = .notesList
    var body: some View {
        TabView(selection: self.$🔖tab) {
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
            📱.🚩showNotesImportSheet = false
            📱.🚩showNoteSheet = false
            if 🔗.description == "NewNoteShortcut" {
                📱.addNewNote()
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            } else if 📱.📚notes.contains(where: { $0.id.description == 🔗.description }) {
                📱.🚩showNoteSheet = true
                📱.🆔openedNoteID = 🔗.description
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
            🔖tab = .notesList
        }
        .sheet(isPresented: $📱.🚩showNoteSheet) {
            📖NoteSheet()
        }
        .sheet(isPresented: $📱.🚩showNotesImportSheet) {
            📥NotesImportSheet()
        }
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
            ScrollViewReader { 🚡 in
                List {
                    Self.🚩RandomModeSection()
                    Section {
                        self.🆕newNoteButton()
                            .id("NewNoteButton")
                            .onOpenURL {
                                if $0.description == "NewNoteShortcut" {
                                    🚡.scrollTo("NewNoteButton")
                                }
                            }
                        ForEach($📱.📚notes) { ⓝote in
                            Self.📓NoteRow(ⓝote)
                        }
                        .onDelete { 📱.📚notes.remove(atOffsets: $0) }
                        .onMove { 📱.📚notes.move(fromOffsets: $0, toOffset: $1) }
                    } footer: {
                        Text("Notes count: \(📱.📚notes.count.description)")
                            .opacity(📱.📚notes.count < 6  ? 0 : 1)
                    }
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
                            📱.🚩showNotesImportSheet.toggle()
                        } label: {
                            Label("Import notes", systemImage: "tray.and.arrow.down")
                        }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    private struct 🚩RandomModeSection: View {
        @AppStorage("RandomMode", store: 💾AppGroupUD) var 🚩randomMode: Bool = false
        var body: some View {
            Section {
                Toggle(isOn: self.$🚩randomMode) {
                    Label("Random mode", systemImage: "shuffle")
                        .padding(.vertical, 8)
                }
                .onChange(of: self.🚩randomMode) { _ in
                    WidgetCenter.shared.reloadAllTimelines()
                }
            } footer: {
                Text("Change the note per 5 minutes.")
            }
        }
    }
    private func 🆕newNoteButton() -> some View {
        Button {
            📱.addNewNote()
        } label: {
            Label("New note", systemImage: "plus")
                .font(.title3.weight(.semibold))
                .padding(.vertical, 7)
        }
        .disabled(📱.📚notes.first?.title == "")
    }
    private struct 📓NoteRow: View {
        @EnvironmentObject var 📱: 📱AppModel
        @Environment(\.scenePhase) var scenePhase
        @AppStorage("RandomMode", store: 💾AppGroupUD) var 🚩randomMode: Bool = false
        @FocusState private var 🔍focus: 🄵ocusPattern?
        @Binding private var ⓝote: 📗Note
        private var 🎨thin: Bool { !self.🚩randomMode && 📱.📚notes.first != ⓝote }
        private var 🚩focusDisable: Bool {
            📱.🚩showNotesImportSheet || 📱.🚩showNoteSheet || self.scenePhase != .active
        }
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    TextField("+ title", text: self.$ⓝote.title)
                        .focused(self.$🔍focus, equals: .title)
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(self.🎨thin ? .tertiary : .primary)
                    TextField("+ comment", text: self.$ⓝote.comment)
                        .focused(self.$🔍focus, equals: .comment)
                        .font(.title3.weight(.light))
                        .foregroundStyle(self.🎨thin ? .tertiary : .secondary)
                        .opacity(0.8)
                }
                .onSubmit { UISelectionFeedbackGenerator().selectionChanged() }
                .padding(8)
                .padding(.vertical, 6)
                .accessibilityHidden(!self.ⓝote.title.isEmpty)
                Menu {
                    Button {
                        📱.🆔openedNoteID = self.ⓝote.id.description
                        📱.🚩showNoteSheet = true
                        UISelectionFeedbackGenerator().selectionChanged()
                    } label: {
                        Label("Detail", systemImage: "doc.plaintext")
                    }
                    Button {
                        guard let ⓘndex = 📱.📚notes.firstIndex(of: self.ⓝote) else { return }
                        📱.addNewNote(ⓘndex + 1)
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
            .onChange(of: self.🚩focusDisable) {
                if $0 { self.🔍focus = nil }
            }
            .onChange(of: 📱.🆕newNoteID) {
                if $0 == self.ⓝote.id {
                    self.🔍focus = .title
                    📱.🆕newNoteID = nil
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


struct 📖NoteSheet: View {
    @EnvironmentObject var 📱: 📱AppModel
    @EnvironmentObject var 🛒: 🛒StoreModel
    @Environment(\.dismiss) var ﹀dismiss
    @State private var 🚩showADMenuSheet: Bool = false
    @FocusState private var 🔍commentFocus: Bool
    private var 🔢noteIndex: Int? {
        📱.📚notes.firstIndex { $0.id.uuidString == 📱.🆔openedNoteID }
    }
    var body: some View {
        NavigationView {
            GeometryReader { 📐 in
                VStack {
                    Spacer()
                    if let 🔢noteIndex {
                        TextField("No title", text: $📱.📚notes[🔢noteIndex].title)
                            .font(.title.bold())
                            .multilineTextAlignment(.center)
                            .accessibilityHidden(true)
                        TextEditor(text: $📱.📚notes[🔢noteIndex].comment)
                            .focused(self.$🔍commentFocus)
                            .multilineTextAlignment(.center)
                            .font(.title3.weight(.light))
                            .foregroundStyle(.secondary)
                            .frame(minHeight: 50, maxHeight: 180)
                            .accessibilityHidden(true)
                            .overlay(alignment: .top) {
                                if 📱.📚notes[🔢noteIndex].comment.isEmpty {
                                    Text("No comment")
                                        .foregroundStyle(.quaternary)
                                        .padding(6)
                                        .allowsHitTesting(false)
                                }
                            }
                            .overlay(alignment: .bottomTrailing) {
                                if self.🔍commentFocus {
                                    Button {
                                        self.🔍commentFocus = false
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
                                📱.📚notes.remove(at: 🔢noteIndex)
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            } label: {
                                Label("Delete", systemImage: "trash")
                                    .font(.title3.bold())
                                    .foregroundStyle(.secondary)
                                    .labelStyle(.iconOnly)
                            }
                            .tint(.red)
                            📗SystemDictionaryButton(🔢noteIndex)
                                .font(.title3.weight(.semibold))
                                .foregroundStyle(.tertiary)
                            🔍SearchButton(🔢noteIndex)
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
                        📣ADView(without: .MemorizeWidget, self.$🚩showADMenuSheet)
                            .frame(height: 160)
                    }
                }
                .modifier(📣ADMenuSheet(self.$🚩showADMenuSheet))
                .animation(.default.speed(1.5), value: self.🔢noteIndex)
                .padding(24)
                .toolbar {
                    Button {
                        self.﹀dismiss.callAsFunction()
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
                Self.💬CommentOnWidgetSection()
                Self.🔍CustomizeSearchSection()
                if #available(iOS 16.0, *) {
                    Section {
                        Text("If lock screen widgets don't update, please close this app or switch to another app.")
                    } header: {
                        Text("Directions")
                    }
                }
                self.💣deleteAllNotesButton()
            }
            .navigationTitle("Option")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    private struct 💬CommentOnWidgetSection: View {
        @AppStorage("ShowComment", store: 💾AppGroupUD) var 🚩showComment: Bool = false
        var body: some View {
            Section {
                Toggle(isOn: self.$🚩showComment) {
                    Label("Show comment on widget", systemImage: "text.append")
                        .padding(.vertical, 8)
                }
                .onChange(of: self.🚩showComment) { _ in
                    WidgetCenter.shared.reloadAllTimelines()
                }
                VStack(spacing: 16) {
                    self.🏞beforeAfterImage("homeSmall_commentOff", "homeSmall_commentOn")
                    if #available(iOS 16.0, *) {
                        self.🏞beforeAfterImage("lockscreen_commentOff", "lockscreen_commentOn")
                    }
                }
                .padding()
                .frame(maxHeight: 500)
            }
        }
        private func 🏞beforeAfterImage(_ ⓑefore: String, _ ⓐfter: String) -> some View {
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
    private struct 🔍CustomizeSearchSection: View {
        @AppStorage("SearchLeadingText") var 🔗leading: String = ""
        @AppStorage("SearchTrailingText") var 🔗trailing: String = ""
        var body: some View {
            Section {
                VStack {
                    let ⓛeading = self.🔗leading.isEmpty ? "https://duckduckgo.com/?q=" : self.🔗leading
                    Text(ⓛeading + "NOTETITLE" + self.🔗trailing)
                        .italic()
                        .font(.system(.footnote, design: .monospaced))
                        .multilineTextAlignment(.center)
                        .padding(8)
                        .frame(minHeight: 100)
                        .animation(.default, value: self.🔗leading.isEmpty)
                        .foregroundStyle(self.🔗leading.isEmpty ? .secondary : .primary)
                    TextField("URL scheme", text: self.$🔗leading)
                    TextField("Trailing component", text: self.$🔗trailing)
                        .font(.caption)
                        .padding(.bottom, 4)
                }
                .textFieldStyle(.roundedBorder)
            } header: {
                Label("Customize search", systemImage: "magnifyingglass")
            } footer: {
                Text("Pre-installed shortcut to search in DuckDuckGo.")
            }
            .headerProminence(.increased)
        }
    }
    private func 💣deleteAllNotesButton() -> some View {
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
                self.ⓛistView()
                    .toolbar(.visible, for: .navigationBar)
            }
        } else {
            NavigationView { self.ⓛistView() }
                .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    private func ⓛistView() -> some View {
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


struct 📥NotesImportSheet: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🚩showFileImporter: Bool = false
    @AppStorage("InputMode", store: 💾AppGroupUD) var ⓘnputMode: 🄸nputMode = .file
    @AppStorage("separator", store: 💾AppGroupUD) var ⓢeparator: 🅂eparator = .tab
    @State private var ⓟastedText: String = ""
    @State private var ⓘmportedText: String = ""
    private var ⓝotes: [📗Note] {
        🄲onvertTextToNotes(self.ⓘmportedText, self.ⓢeparator)
    }
    @FocusState private var 🔍textFieldFocus: Bool
    @State private var 🚨showErrorAlert: Bool = false
    @State private var 🚨errorMessage: String = ""
    var body: some View {
        NavigationView {
            List {
                if self.ⓝotes.isEmpty {
                    Picker(selection: self.$ⓘnputMode) {
                        Label("File", systemImage: "doc").tag(🄸nputMode.file)
                        Label("Text", systemImage: "text.justify.left").tag(🄸nputMode.text)
                    } label: {
                        Label("Mode", systemImage: "tray.and.arrow.down")
                    }
                    self.ⓢeparatorPicker()
                    switch self.ⓘnputMode {
                        case .file:
                            Section {
                                Button {
                                    self.🚩showFileImporter.toggle()
                                } label: {
                                    Label("Import a text-encoded file", systemImage: "folder.badge.plus")
                                        .padding(.vertical, 8)
                                }
                            }
                            self.ⓔxampleSection()
                        case .text:
                            Section {
                                TextEditor(text: self.$ⓟastedText)
                                    .focused(self.$🔍textFieldFocus)
                                    .font(.subheadline.monospaced())
                                    .frame(height: 100)
                                    .padding(8)
                                    .overlay {
                                        if self.ⓟastedText.isEmpty {
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
                                                self.🔍textFieldFocus = false
                                            } label: {
                                                Label("Done", systemImage: "keyboard.chevron.compact.down")
                                            }
                                        }
                                    }
                                Button {
                                    self.ⓘmportedText = self.ⓟastedText
                                } label: {
                                    Label("Convert this text to notes", systemImage: "text.badge.plus")
                                        .padding(.vertical, 8)
                                }
                                .disabled(self.ⓟastedText.isEmpty)
                            }
                            .animation(.default, value: self.ⓟastedText.isEmpty)
                            self.ⓔxampleSection()
                    }
                    self.ⓝotSupportMultiLineTextInNote()
                } else {
                    self.ⓢeparatorPicker()
                    Section {
                        ForEach(self.ⓝotes) { ⓝote in
                            VStack(alignment: .leading) {
                                Text(ⓝote.title)
                                Text(ⓝote.comment)
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 8)
                        }
                    } header: {
                        Text("Notes count: \(self.ⓝotes.count.description)")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if !self.ⓝotes.isEmpty {
                        Button(role: .cancel) {
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            self.ⓘmportedText = ""
                        } label: {
                            Label("Cancel", systemImage: "xmark")
                                .font(.body.weight(.semibold))
                        }
                        .tint(.red)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !self.ⓝotes.isEmpty {
                        Button {
                            📱.🚩showNotesImportSheet = false
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                📱.📚notes.insert(contentsOf: self.ⓝotes, at: 0)
                                self.ⓘmportedText = ""
                            }
                        } label: {
                            Label("Done", systemImage: "checkmark")
                                .font(.body.weight(.semibold))
                        }
                    }
                }
                ToolbarItem(placement: .principal) {
                    Button {
                        📱.🚩showNotesImportSheet = false
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
        .animation(.default, value: self.ⓝotes)
        .animation(.default, value: self.ⓘnputMode)
        .fileImporter(isPresented: self.$🚩showFileImporter, allowedContentTypes: [.text]) { 📦result in
            do {
                let 📦 = try 📦result.get()
                if 📦.startAccessingSecurityScopedResource() {
                    self.ⓘmportedText = try String(contentsOf: 📦)
                    📦.stopAccessingSecurityScopedResource()
                }
            } catch {
                self.🚨errorMessage = error.localizedDescription
                self.🚨showErrorAlert = true
            }
        }
        .alert("⚠️", isPresented: self.$🚨showErrorAlert) {
            Button("OK") {
                self.🚨showErrorAlert = false
                self.🚨errorMessage = ""
            }
        } message: {
            Text(self.🚨errorMessage)
        }
    }
    private func ⓢeparatorPicker() -> some View {
        Picker(selection: self.$ⓢeparator) {
            Text("Tab ␣ ")
                .tag(🅂eparator.tab)
                .accessibilityLabel("Tab")
            Text("Comma , ")
                .tag(🅂eparator.comma)
                .accessibilityLabel("Comma")
            Text("(Title only)")
                .tag(🅂eparator.titleOnly)
                .accessibilityLabel("Title only")
        } label: {
            Label("Separator", systemImage: "arrowtriangle.left.and.line.vertical.and.arrowtriangle.right")
        }
    }
    private func ⓔxampleSection() -> some View {
        Section {
            switch self.ⓘnputMode {
                case .file:
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
                case .text:
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
            }
        } header: {
            Text("Example")
        }
    }
    private func ⓝotSupportMultiLineTextInNote() -> some View {
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
    @State private var 🚩showSystemDictionary: Bool = false
    private var 🔢noteIndex: Int
    var body: some View {
        Button {
            self.🚩showSystemDictionary = true
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
                .labelStyle(.iconOnly)
        }
        .sheet(isPresented: self.$🚩showSystemDictionary) {
            Self.📗SystemDictionarySheet(term: 📱.📚notes[self.🔢noteIndex].title)
        }
    }
    init(_ noteIndex: Int) {
        self.🔢noteIndex = noteIndex
    }
    private struct 📗SystemDictionarySheet: View {
        private var ⓣerm: String
        var body: some View {
            Self.🄳ictinaryView(term: self.ⓣerm)
                .ignoresSafeArea()
        }
        private struct 🄳ictinaryView: UIViewControllerRepresentable {
            private var ⓣerm: String
            func makeUIViewController(context: Context) -> UIReferenceLibraryViewController {
                UIReferenceLibraryViewController(term: self.ⓣerm)
            }
            func updateUIViewController(_ uiViewController: UIReferenceLibraryViewController, context: Context) {}
            init(term: String) {
                self.ⓣerm = term
            }
        }
        init(term: String) {
            self.ⓣerm = term
        }
    }
}


struct 🔍SearchButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    @AppStorage("SearchLeadingText") var 🔗leading: String = ""
    @AppStorage("SearchTrailingText") var 🔗trailing: String = ""
    @Environment(\.openURL) var openURL
    private var 🔢noteIndex: Int
    var body: some View {
        Button {
            let ⓛeading = self.🔗leading.isEmpty ? "https://duckduckgo.com/?q=" : self.🔗leading
            let ⓣext = ⓛeading + 📱.📚notes[self.🔢noteIndex].title + self.🔗trailing
            guard let ⓔncodedText = ⓣext.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
            guard let ⓤrl = URL(string: ⓔncodedText) else { return }
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            self.openURL(ⓤrl)
        } label: {
            Label("Search", systemImage: "magnifyingglass")
                .labelStyle(.iconOnly)
        }
    }
    init(_ noteIndex: Int) {
        self.🔢noteIndex = noteIndex
    }
}


struct 💾OperateData: ViewModifier {
    @EnvironmentObject var 📱: 📱AppModel
    @AppStorage("savedDataByShareExtension", store: 💾AppGroupUD) private var 🚩savedDataByShareExtension: Bool = false
    func body(content: Content) -> some View {
        content
            .onChange(of: 📱.📚notes) { _ in
                📱.saveNotes()
            }
            .onAppear {
                self.🚩savedDataByShareExtension = false
            }
            .onChange(of: self.🚩savedDataByShareExtension) {
                if $0 == true {
                    📱.loadNotes()
                    self.🚩savedDataByShareExtension = false
                }
            }
    }
}




//MARK: - REJECT .defaultAppStorage(UserDefaults(suiteName: `AppGroupID`)!)
//reason: buggy list-animation on iOS15.x
