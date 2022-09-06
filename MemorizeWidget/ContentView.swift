
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
            
            Text("Menu View")
                .tabItem {
                    Label("Menu", systemImage: "gearshape")
                        .labelStyle(.iconOnly)
                }
        }
        .onChange(of: 📱.🚩RandomMode) { _ in
            WidgetCenter.shared.reloadAllTimelines()
        }
        .onOpenURL { 🔗 in
            📱.🚩ShowWidgetItem = true
            📱.🆔WidgetItem = 🔗.description
        }
        .sheet(isPresented: $📱.🚩ShowWidgetItem) {
            🪧WidgetItemSheet()
        }
        .onChange(of: 📱.🗃Items) { _ in
            📱.💾SaveItems()
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
            
            if 📱.🗃Items.isEmpty {
                🆕NewItemFormOnMain()
            } else {
                🗒ItemRow($📱.🗃Items.first!)
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
                
                🆕NewItemView()
                
                ForEach($📱.🗃Items) { ⓘtem in
                    🗒ItemRow(ⓘtem)
                }
                .onDelete { ⓘndexSet in
                    📱.🗃Items.remove(atOffsets: ⓘndexSet)
                }
                .onMove { ⓘndexSet, ⓘnt in
                    📱.🗃Items.move(fromOffsets: ⓘndexSet, toOffset: ⓘnt)
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


struct 🗒ItemRow: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Binding var ⓘtem: 🗒Item
    var 🎨Thin: Bool { !📱.🚩RandomMode && 📱.🗃Items.first != ⓘtem }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField("+ title", text: $ⓘtem.ⓣitle)
                .font(.title.weight(.semibold))
                .foregroundStyle(🎨Thin ? .tertiary : .primary)
            TextField("+ comment", text: $ⓘtem.ⓒomment)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(🎨Thin ? .tertiary : .secondary)
                .opacity(0.8)
        }
        .padding(8)
        .padding(.vertical, 8)
    }
    
    init(_ ⓘtem: Binding<🗒Item>) {
        self._ⓘtem = ⓘtem
    }
}


struct 🆕NewItemFormOnMain: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var ⓣitle: String = ""
    
    var body: some View {
        TextField("+ New item", text: $ⓣitle)
            .font(.title2.weight(.semibold))
            .padding(32)
            .textFieldStyle(.roundedBorder)
            .onSubmit {
                📱.🗃Items.append(🗒Item(ⓣitle))
            }
    }
}

struct 🆕NewItemView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @FocusState private var 🔍Focus: 🄵ocusPattern?
    
    var body: some View {
        VStack(spacing: 2) {
            TextField("+ new item", text: $📱.🆕Item.ⓣitle)
                .font(.title2.bold())
                .focused($🔍Focus, equals: .ⓣitle)
            
            TextField("comment", text: $📱.🆕Item.ⓒomment)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)
                .focused($🔍Focus, equals: .ⓒomment)
                .disabled(📱.🆕Item.ⓣitle == "")
                .padding(.leading, 8)
        }
        .onSubmit {
            🅂ubmit()
        }
        .padding(8)
        .overlay(alignment: .trailing) {
            if 🔍Focus != nil {
                Button {
                    🔍Focus = .ⓣitle
                    🅂ubmit()
                } label: {
                    Image(systemName: "plus.rectangle.on.rectangle")
                        .font(.title3)
                        .foregroundStyle(.tertiary)
                }
                .buttonStyle(.plain)
                .disabled(📱.🆕Item.ⓣitle == "")
            }
        }
    }
    
    func 🅂ubmit() {
        if 📱.🆕Item.ⓣitle == "" { return }
        
        withAnimation {
            📱.🗃Items.insert(📱.🆕Item, at: 0)
            📱.🆕Item = .init("")
        }
    }
    
    enum 🄵ocusPattern {
        case ⓣitle
        case ⓒomment
    }
}


struct 🪧WidgetItemSheet: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Environment(\.dismiss) var ﹀Dismiss: DismissAction
    var 🔢ItemIndex: Int? {
        📱.🗃Items.firstIndex { $0.id.uuidString == 📱.🆔WidgetItem }
    }
    
    var body: some View {
        ZStack {
            Color.clear
            
            if let 🔢 = 🔢ItemIndex {
                VStack {
                    TextField("No title", text: $📱.🗃Items[🔢].ⓣitle)
                        .font(.largeTitle.bold())
                    TextField("No comment", text: $📱.🗃Items[🔢].ⓒomment)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                    
                    Button(role: .destructive) {
                        📱.🗃Items.remove(at: 🔢)
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
        .animation(.default, value: 🔢ItemIndex)
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
