import SwiftUI

struct ℹ️AboutAppTab: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ℹ️IconAndName()
                    ℹ️AppStoreLink()
                    NavigationLink {
                        List {
                            ℹ️AboutAppContent()
                        }
                        .navigationTitle(.init("About App", tableName: "🌐AboutApp"))
                    } label: {
                        Label(String(localized: "About App", table: "🌐AboutApp"),
                              systemImage: "doc")
                    }
                }
                🛒InAppPurchaseMenuLink()
            }
            .navigationTitle("App")
            //.navigationBarTitleDisplayMode(.inline)
            //↑ WorkaroundIOS17Bug(navigationTitleMode/navigationLinkPotision)
        }
    }
}
