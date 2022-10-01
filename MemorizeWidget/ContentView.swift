
import SwiftUI
import WidgetKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🔖Tab: 🔖TabTag = .notesList
    var body: some View {
        TabView(selection: $🔖Tab) {
            🗃NotesListTab()
                .tag(🔖TabTag.notesList)
                .tabItem { Label("Notes", systemImage: "text.justify.leading") }
            🔩OptionTab()
                .tag(🔖TabTag.option)
                .tabItem { Label("Option", systemImage: "gearshape") }
            ℹ️AboutAppTab()
                .tag(🔖TabTag.about)
                .tabItem { Label("About App", systemImage: "questionmark") }
        }
        .onChange(of: 📱.🚩RandomMode) { _ in
            WidgetCenter.shared.reloadAllTimelines()
        }
        .onOpenURL { 🔗 in
            if !📱.🗃Notes.isEmpty && (🔗.description != "NewItemShortcut") {
                📱.🚩ShowFileImporSheet = false
                📱.🚩ShowWidgetNote = true
                📱.🆔WidgetNoteID = 🔗.description
            }
            🔖Tab = .notesList
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
        .sheet(isPresented: $📱.🚩ShowWidgetNote) {
            🪧WidgetNoteSheet()
        }
        .sheet(isPresented: $📱.🚩ShowFileImporSheet) {
            📂FileImportSheet()
        }
        .onChange(of: 📱.🗃Notes) { _ in
            📱.💾SaveNotes()
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    enum 🔖TabTag {
        case notesList, option, about
    }
}


struct 🗃NotesListTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationView {
            List {
                Section {
                    Toggle(isOn: 📱.$🚩RandomMode) {
                        Label("Random mode", systemImage: "shuffle")
                            .padding(.vertical, 12)
                    }
                } footer: {
                    Text("Change the note per 5 minutes.")
                }
                
                Button {
                    📱.🗃Notes.insert(📓Note(""), at: 0)
                } label: {
                    Label("New note", systemImage: "plus")
                }
                
                ForEach($📱.🗃Notes) { ⓝote in
                    📓NoteRow(ⓝote)
                }
                .onDelete { ⓘndexSet in
                    📱.🗃Notes.remove(atOffsets: ⓘndexSet)
                }
                .onMove { ⓘndexSet, ⓘnt in
                    📱.🗃Notes.move(fromOffsets: ⓘndexSet, toOffset: ⓘnt)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .animation(.default, value: 📱.🗃Notes)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        UISelectionFeedbackGenerator().selectionChanged()
                        📱.🚩ShowFileImporSheet.toggle()
                    } label: {
                        Label("Import TSV file", systemImage: "arrow.down.doc")
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct 📓NoteRow: View {
    @EnvironmentObject var 📱: 📱AppModel
    @FocusState private var 🔍Focus: Bool
    @Binding var ⓝote: 📓Note
    var 🎨Thin: Bool { !📱.🚩RandomMode && 📱.🗃Notes.first != ⓝote }
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                TextField("+ title", text: $ⓝote.title)
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(🎨Thin ? .tertiary : .primary)
                    .focused($🔍Focus)
                TextField("+ comment", text: $ⓝote.comment)
                    .font(.footnote)
                    .foregroundStyle(🎨Thin ? .tertiary : .secondary)
                    .opacity(0.8)
            }
            .padding(8)
            .padding(.vertical, 8)
            
            Button {
                guard let ⓘndex = 📱.🗃Notes.firstIndex(of: ⓝote) else { return }
                📱.🗃Notes.insert(.init(""), at: ⓘndex+1)
            } label: {
                Label("New note", systemImage: "text.append")
                    .labelStyle(.iconOnly)
                    .foregroundStyle(.secondary)
                    .imageScale(.small)
            }
            .buttonStyle(.borderless)
        }
        .onAppear {
            if ⓝote.title == "" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    🔍Focus = true
                }
            }
        }
        .onChange(of: 🔍Focus) { ⓝewValue in
            if ⓝewValue == false {
                if ⓝote.title == "" {
                    📱.🗃Notes.removeAll(where: { $0 == ⓝote })
                }
            }
        }
    }
    init(_ ⓝote: Binding<📓Note>) {
        self._ⓝote = ⓝote
    }
}


//struct 🆕NewNoteView: View {
//    @EnvironmentObject var 📱: 📱AppModel
//    @FocusState private var 🔍Focus: 🄵ocusPattern?
//    var body: some View {
//        VStack(spacing: 2) {
//            TextField("+ new note", text: $📱.🆕NewNote.title)
//                .font(.title2.bold())
//                .focused($🔍Focus, equals: .title)
//            TextField("comment", text: $📱.🆕NewNote.comment)
//                .font(.subheadline.weight(.medium))
//                .foregroundStyle(.secondary)
//                .focused($🔍Focus, equals: .comment)
//                .disabled(📱.🆕NewNote.title == "")
//                .opacity(📱.🆕NewNote.title == "" ? 0.6 : 1)
//                .padding(.leading, 8)
//        }
//        .onSubmit { 🅂ubmit() }
//        .padding(8)
//        .overlay(alignment: .trailing) {
//            if 🔍Focus != nil {
//                Button {
//                    🅂ubmit()
//                    🔍Focus = .title
//                } label: {
//                    Image(systemName: "plus.rectangle.on.rectangle")
//                        .font(.title3)
//                        .foregroundStyle(.tertiary)
//                }
//                .buttonStyle(.plain)
//                .disabled(📱.🆕NewNote.title == "")
//            }
//        }
//        .onOpenURL { 🔗 in
//            if 🔗.description == "NewItemShortcut" {
//                🔍Focus = .title
//            }
//        }
//    }
//
//    func 🅂ubmit() {
//        if 📱.🆕NewNote.title == "" { return }
//        UISelectionFeedbackGenerator().selectionChanged()
//        withAnimation {
//            📱.🗃Notes.insert(📱.🆕NewNote, at: 0)
//            📱.🆕NewNote = .init("")
//        }
//    }
//
//    enum 🄵ocusPattern {
//        case title, comment
//    }
//}


struct 🪧WidgetNoteSheet: View {
    @EnvironmentObject var 📱: 📱AppModel
    @EnvironmentObject var 🛒: 🛒StoreModel
    @Environment(\.dismiss) var ﹀Dismiss: DismissAction
    var 🔢NoteIndex: Int? {
        📱.🗃Notes.firstIndex { $0.id.uuidString == 📱.🆔WidgetNoteID }
    }
    
    var body: some View {
        ZStack {
            Color.clear
            VStack {
                Spacer()
                if let 🔢 = 🔢NoteIndex {
                    TextField("No title", text: $📱.🗃Notes[🔢].title)
                        .font(.title3.bold())
                    TextField("No comment", text: $📱.🗃Notes[🔢].comment)
                        .foregroundStyle(.secondary)
                    Button(role: .destructive) {
                        📱.🗃Notes.remove(at: 🔢)
                        UINotificationFeedbackGenerator().notificationOccurred(.warning)
                    } label: {
                        Image(systemName: "trash")
                            .font(.title3.bold())
                            .foregroundStyle(.secondary)
                    }
                    .tint(.red)
                    .padding(.top, 64)
                } else {
                    VStack(spacing: 24) {
                        Label("Deleted.", systemImage: "checkmark")
                        Image(systemName: "trash")
                    }
                    .imageScale(.small)
                    .font(.largeTitle)
                }
                Spacer()
                ZStack {
                    Color.clear
                    if 🛒.🚩ADisActive {
                        📣ADView()
                            .padding()
                            .transition(.opacity)
                    }
                }
                .frame(height: 100)
                .animation(.default, value: 🛒.🚩Purchased)
            }
        }
        .animation(.default.speed(1.5), value: 🔢NoteIndex)
        .padding(24)
        .overlay(alignment: .topTrailing) {
            Button {
                ﹀Dismiss.callAsFunction()
                UISelectionFeedbackGenerator().selectionChanged()
            } label: {
                Image(systemName: "chevron.down")
                    .padding(24)
            }
            .tint(.secondary)
            .accessibilityLabel("Dismiss")
        }
    }
}


struct 🔩OptionTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationView {
            List {
                Section {
                    Toggle(isOn: 📱.$🚩ShowComment) {
                        Label("Show comment on widget", systemImage: "text.append")
                            .padding(.vertical, 8)
                    }
                    .onChange(of: 📱.🚩ShowComment) { _ in
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
                
                if #available(iOS 16.0, *) {
                    Section {
                        Text("If lock screen widgets don't update, please close this app or switch to another app.")
                    } header: {
                        Text("Directions")
                    }
                }
                
                📣ADMenuLink()
            }
            .navigationTitle("Option")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    struct 🏞BeforeAfterImage: View {
        var ⓑefore: String
        var ⓐfter: String
        var body: some View {
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
        init(_ ⓑefore: String, _ ⓐfter: String) {
            self.ⓑefore = ⓑefore
            self.ⓐfter = ⓐfter
        }
    }
}


struct 📂FileImportSheet: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🚩ShowFileImporter: Bool = false
    @State private var 📓ImportedNotes: [📓Note] = []
    var body: some View {
        NavigationView {
            List {
                if 📓ImportedNotes.isEmpty {
                    Button {
                        🚩ShowFileImporter.toggle()
                    } label: {
                        Label("Import TSV file", systemImage: "arrow.down.doc")
                            .font(.title2.weight(.semibold))
                            .padding(.vertical, 8)
                    }
                    
                    Section {
                        HStack {
                            Image("tsvImport_before")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(12)
                                .shadow(radius: 2)
                            Image(systemName: "arrow.right")
                                .font(.title2.weight(.semibold))
                            Image("tsvImport_after")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(12)
                                .shadow(radius: 2)
                        }
                        .frame(maxHeight: 400)
                        .padding(.horizontal, 8)
                        .padding(.vertical)
                        
                        Image("numbers_tsv_export")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .shadow(radius: 2)
                            .padding()
                            .frame(maxHeight: 250)
                    }
                }
                
                ForEach(📓ImportedNotes) { note in
                    VStack(alignment: .leading) {
                        Text(note.title)
                        Text(note.comment)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .padding(.leading, 8)
                    }
                    .padding(.vertical, 8)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if !📓ImportedNotes.isEmpty {
                        Button(role: .cancel) {
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            📓ImportedNotes = []
                        } label: {
                            Label("Cancel", systemImage: "xmark")
                                .font(.body.weight(.semibold))
                        }
                        .tint(.red)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !📓ImportedNotes.isEmpty {
                        Button {
                            📱.🚩ShowFileImporSheet = false
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                📱.🗃Notes.insert(contentsOf: 📓ImportedNotes, at: 0)
                                📓ImportedNotes = []
                            }
                        } label: {
                            Label("Done", systemImage: "checkmark")
                                .font(.body.weight(.semibold))
                        }
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Button {
                        📱.🚩ShowFileImporSheet = false
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
        }
        .animation(.default, value: 📓ImportedNotes)
        .fileImporter(isPresented: $🚩ShowFileImporter, allowedContentTypes: [.tabSeparatedText]) { 📦Result in
            📓ImportedNotes = 📂ImportTSVFile(📦Result)
        }
    }
}


struct ℹ️AboutAppTab: View {
    var body: some View {
        NavigationView {
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
                    
                    NavigationLink  {
                        ℹ️AboutAppMenu()
                    } label: {
                        Label("About App", systemImage: "doc")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
