
import SwiftUI
import StoreKit

struct 📣ADMenuLink: View {
    @EnvironmentObject var 🛒: 🛒StoreModel
    
    var body: some View {
        Section {
            🛒PurchaseView()
            
            NavigationLink {
                📣ADMenu()
            } label: {
                Label("About AD / Purchase", systemImage: "megaphone")
            }
        } header: {
            Text("AD / Purchase")
        }
    }
}

struct 📣ADMenu: View {
    @EnvironmentObject var 🛒: 🛒StoreModel
    
    var body: some View {
        List {
            Section {
                Text("This App shows banner advertisement about applications on AppStore. These are several Apps by this app's developer. It is activated after you launch this app 5 times.")
                    .padding()
                    .textSelection(.enabled)
            } header: {
                Text("Description")
            }
            
            Section {
                🛒PurchaseView()
                🛒ProductPreview()
                🛒RestoreButton()
            } header: {
                Text("In-App Purchase")
            }
            
            Section {
                ForEach(📣AppName.allCases) { 🏷 in
                    📣ADView(🏷)
                }
            }
        }
        .navigationTitle("AD / Purchase")
    }
}
