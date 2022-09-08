
import SwiftUI
import WidgetKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🔖Tag: 🔖TabTag = .notesList
    
    var body: some View {
        TabView(selection: $🔖Tag) {
            🗃NotesListTab()
                .tabItem {
                    Label("Notes", systemImage: "text.justify.leading")
                }
                .tag(🔖TabTag.notesList)
            
            🔩OptionTab()
                .tabItem {
                    Label("Option", systemImage: "gearshape")
                }
                .tag(🔖TabTag.option)
            
            ℹ️AboutAppTab()
                .tabItem {
                    Label("About App", systemImage: "questionmark")
                }
                .tag(🔖TabTag.aboutApp)
        }
        .onChange(of: 📱.🚩RandomMode) { _ in
            WidgetCenter.shared.reloadAllTimelines()
        }
        .onOpenURL { 🔗 in
            if !📱.🗃Notes.isEmpty {
                📱.🚩ShowWidgetNote = true
                📱.🆔WidgetNoteID = 🔗.description
            }
            🔖Tag = .notesList
        }
        .sheet(isPresented: $📱.🚩ShowWidgetNote) {
            🪧WidgetNoteSheet()
        }
        .onChange(of: 📱.🗃Notes) { _ in
            📱.💾SaveNotes()
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    enum 🔖TabTag {
        case notesList
        case option
        case aboutApp
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
                            .font(.title3.bold())
                            .padding(.vertical)
                    }
                } footer: {
                    Text("Change the note per 5 minutes.")
                }
                
                🆕NewNoteView()
                
                ForEach($📱.🗃Notes) { ⓝote in
                    📓NoteRow(ⓝote)
                }
                .onDelete { ⓘndexSet in
                    📱.🗃Notes.remove(atOffsets: ⓘndexSet)
                }
                .onMove { ⓘndexSet, ⓘnt in
                    📱.🗃Notes.move(fromOffsets: ⓘndexSet, toOffset: ⓘnt)
                }
                
                Section {
                    Button {
                        📱.🚩ShowFileImporter.toggle()
                    } label: {
                        Label("Import TSV file", systemImage: "arrow.down.doc")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fileImporter(isPresented: $📱.🚩ShowFileImporter, allowedContentTypes: [.tabSeparatedText]) { 📦Result in
            withAnimation {
                📱.🗃Notes.append(contentsOf: 📂ImportTSVFile(📦Result))
            }
        }
    }
}


struct 📓NoteRow: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Binding var ⓝote: 📓Note
    var 🎨Thin: Bool { !📱.🚩RandomMode && 📱.🗃Notes.first != ⓝote }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField("+ title", text: $ⓝote.title)
                .font(.headline.weight(.semibold))
                .foregroundStyle(🎨Thin ? .tertiary : .primary)
            TextField("+ comment", text: $ⓝote.comment)
                .font(.footnote)
                .foregroundStyle(🎨Thin ? .tertiary : .secondary)
                .opacity(0.8)
        }
        .padding(8)
        .padding(.vertical, 8)
    }
    
    init(_ ⓝote: Binding<📓Note>) {
        self._ⓝote = ⓝote
    }
}


struct 🆕NewNoteView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @FocusState private var 🔍Focus: 🄵ocusPattern?
    
    var body: some View {
        VStack(spacing: 2) {
            TextField("+ new note", text: $📱.🆕NewNote.title)
                .font(.title2.bold())
                .focused($🔍Focus, equals: .title)
            
            TextField("comment", text: $📱.🆕NewNote.comment)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)
                .focused($🔍Focus, equals: .comment)
                .disabled(📱.🆕NewNote.title == "")
                .padding(.leading, 8)
        }
        .onSubmit {
            🅂ubmit()
        }
        .padding(8)
        .overlay(alignment: .trailing) {
            if 🔍Focus != nil {
                Button {
                    🔍Focus = .title
                    🅂ubmit()
                } label: {
                    Image(systemName: "plus.rectangle.on.rectangle")
                        .font(.title3)
                        .foregroundStyle(.tertiary)
                }
                .buttonStyle(.plain)
                .disabled(📱.🆕NewNote.title == "")
            }
        }
    }
    
    func 🅂ubmit() {
        if 📱.🆕NewNote.title == "" { return }
        
        withAnimation {
            📱.🗃Notes.insert(📱.🆕NewNote, at: 0)
            📱.🆕NewNote = .init("")
        }
    }
    
    enum 🄵ocusPattern {
        case title
        case comment
    }
}


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
                    if 🛒.🚩Purchased == false {
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
