import SwiftUI

struct ℹ️AboutAppTab: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                self.ⓛistView()
                    .toolbar(.visible, for: .navigationBar)
            }
        } else {
            NavigationView { self.ⓛistView() }
                .navigationViewStyle(.stack)
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
