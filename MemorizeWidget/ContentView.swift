
import SwiftUI
import WidgetKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    
    var body: some View {
        TabView {
            🗃NotesListTab()
                .tabItem {
                    Label("List", systemImage: "text.justify.leading")
                        .labelStyle(.iconOnly)
                }
            
            🛠MenuTab()
                .tabItem {
                    Label("Menu", systemImage: "gearshape")
                        .labelStyle(.iconOnly)
                }
            
            ℹ️AboutAppTab()
                .tabItem {
                    Label("About", systemImage: "questionmark")
                        .labelStyle(.iconOnly)
                }
        }
        .onChange(of: 📱.🚩RandomMode) { _ in
            WidgetCenter.shared.reloadAllTimelines()
        }
        .onOpenURL { 🔗 in
            if !📱.🗃Notes.isEmpty {
                📱.🚩ShowWidgetNote = true
                📱.🆔WidgetNoteID = 🔗.description
            }
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
        .navigationViewStyle(StackNavigationViewStyle())
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


struct 🛠MenuTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    
    var body: some View {
        NavigationView {
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
            .navigationTitle("Menu")
        }
        .navigationViewStyle(StackNavigationViewStyle())
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


struct ℹ️AboutAppTab: View {
    var body: some View {
        NavigationView {
            List {
                ℹ️AboutAppLink()
                📣ADMenuLink()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ℹ️AboutAppLink: View {
    var body: some View {
        Section {
            ZStack {
                Color.clear
                
                VStack(spacing: 12) {
                    Image("FlipByBlink")
                        .resizable()
                        .mask {
                            RoundedRectangle(cornerRadius: 22.5, style: .continuous)
                        }
                        .shadow(radius: 3, y: 1)
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
                .padding(24)
                .padding(.top, 12)
            }
            
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
}
