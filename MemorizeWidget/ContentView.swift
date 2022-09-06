
import SwiftUI
import WidgetKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    
    var body: some View {
        TabView {
            M⃣ainView()
                .tabItem {
                    Label("Main", systemImage: "character.textbox")
                        .labelStyle(.iconOnly)
                }
            
            🗃ListView()
                .tabItem {
                    Label("List", systemImage: "text.badge.plus")
                        .labelStyle(.iconOnly)
                }
            
            🛠MenuView()
                .tabItem {
                    Label("Menu", systemImage: "gearshape")
                        .labelStyle(.iconOnly)
                }
        }
        .onChange(of: 📱.🚩RandomMode) { _ in
            WidgetCenter.shared.reloadAllTimelines()
        }
        .onOpenURL { 🔗 in
            📱.🚩ShowWidgetNote = true
            📱.🆔WidgetNoteID = 🔗.description
        }
        .sheet(isPresented: $📱.🚩ShowWidgetNote) {
            🪧WidgetNoteSheet()
        }
        .onChange(of: 📱.🗃Notes) { _ in
            📱.💾SaveNotes()
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}


struct M⃣ainView: View {
    @EnvironmentObject var 📱: 📱AppModel
    
    var body: some View {
        VStack {
            Text("適用イメージ図(仮)")
                .font(.largeTitle)
                .foregroundColor(.secondary)
                .padding(64)
                .border(.secondary)
            
            if 📱.🗃Notes.isEmpty {
                🆕NewNoteFormOnMain()
            } else {
                📓NoteRow($📱.🗃Notes.first!)
                    .padding(32)
            }
        }
    }
}

struct 🗃ListView: View {
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
                    Text("約5分毎にテキストがランダムで切り替わります。")
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
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
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
                .font(.title.weight(.semibold))
                .foregroundStyle(🎨Thin ? .tertiary : .primary)
            TextField("+ comment", text: $ⓝote.comment)
                .font(.subheadline.weight(.medium))
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


struct 🛠MenuView: View {
    @EnvironmentObject var 📱: 📱AppModel
    
    var body: some View {
        NavigationStack {
            List {
                Toggle(isOn: 📱.$🚩RectangularBackground) {
                    Label("Show rectangular background on lock screen", systemImage: "rectangle.dashed")
                }
                .onChange(of: 📱.🚩RectangularBackground) { _ in
                    WidgetCenter.shared.reloadAllTimelines()
                }
                
                Toggle(isOn: 📱.$🚩ShowComment) {
                    Label("Show comment on widget", systemImage: "list.dash.header.rectangle")
                }
                .onChange(of: 📱.🚩ShowComment) { _ in
                    WidgetCenter.shared.reloadAllTimelines()
                }
            }
        }
    }
}


struct 🆕NewNoteFormOnMain: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var ⓣitle: String = ""
    
    var body: some View {
        TextField("+ New note", text: $ⓣitle)
            .font(.title2.weight(.semibold))
            .padding(32)
            .textFieldStyle(.roundedBorder)
            .onSubmit {
                📱.🗃Notes.append(📓Note(ⓣitle))
            }
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
    @Environment(\.dismiss) var ﹀Dismiss: DismissAction
    var 🔢NoteIndex: Int? {
        📱.🗃Notes.firstIndex { $0.id.uuidString == 📱.🆔WidgetNoteID }
    }
    
    var body: some View {
        ZStack {
            Color.clear
            
            if let 🔢 = 🔢NoteIndex {
                VStack {
                    TextField("No title", text: $📱.🗃Notes[🔢].title)
                        .font(.largeTitle.bold())
                    TextField("No comment", text: $📱.🗃Notes[🔢].comment)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                    
                    Button(role: .destructive) {
                        📱.🗃Notes.remove(at: 🔢)
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.secondary)
                            .font(.title3.bold())
                    }
                    .tint(.red)
                    .padding(.top, 64)
                }
            } else {
                Label("Deleted.", systemImage: "checkmark")
                    .font(.largeTitle)
            }
        }
        .animation(.default, value: 🔢NoteIndex)
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
