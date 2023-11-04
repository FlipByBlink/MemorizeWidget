import SwiftUI
import StoreKit

struct 🛒InAppPurchaseMenuLink: View {
    var body: some View {
        Section {
            🛒PurchaseView()
            NavigationLink {
                🛒InAppPurchaseMenu()
            } label: {
                Label(String(localized: "About AD / Purchase", table: "🌐AD&InAppPurchase"),
                      systemImage: "megaphone")
            }
        } header: {
            Text("AD / Purchase", tableName: "🌐AD&InAppPurchase")
        }
    }
}

struct 🛒InAppPurchaseMenu: View {
    var body: some View {
        List {
            Self.aboutADSection()
            Section {
                🛒PurchaseView()
                🛒Preview()
            } header: {
                Text("In-App Purchase", tableName: "🌐AD&InAppPurchase")
            }
            .headerProminence(.increased)
            🛒RestoreButton()
        }
        .navigationTitle(.init("About AD", tableName: "🌐AD&InAppPurchase"))
    }
    private static func aboutADSection() -> some View {
        Section {
            Text("This App shows advertisement about applications on App Store. These are several Apps by this app's developer. It is activated after you launch this app 5 times.",
                 tableName: "🌐AD&InAppPurchase")
            .padding()
        } header: {
            Text("Description", tableName: "🌐AD&InAppPurchase")
        }
    }
}

private struct 🛒Preview: View {
    var body: some View {
        HStack(alignment: .bottom) {
            Spacer()
            Image(.adPreview)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 300)
                .padding(.leading, 45)
            Image(systemName: "trash.square.fill")
                .resizable()
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .red)
                .frame(width: 60, height: 60)
                .rotationEffect(.degrees(8))
                .offset(x: -45)
                .shadow(radius: 5)
                .padding(.bottom, 60)
            Spacer()
        }
        .padding(24)
    }
}

private struct 🛒PurchaseView: View {
    @EnvironmentObject var model: 🛒InAppPurchaseModel
    @State private var buyingInProgress = false
    @State private var showError = false
    @State private var errorMessage = ""
    var body: some View {
        HStack {
            Label(self.model.productName, systemImage: "cart")
            Spacer()
            if self.model.purchased {
                Image(systemName: "checkmark")
                    .imageScale(.small)
                    .foregroundStyle(.tertiary)
                    .transition(.slide)
            }
            Button(self.model.productPrice) {
                Task {
                    do {
                        self.buyingInProgress = true
                        try await self.model.purchase()
                    } catch 🛒Error.failedVerification {
                        self.errorMessage = "Your purchase could not be verified by the App Store."
                        self.showError = true
                    } catch {
                        print("Failed purchase: \(error)")
                        self.errorMessage = error.localizedDescription
                        self.showError = true
                    }
                    self.buyingInProgress = false
                }
            }
            .accessibilityLabel(Text("Buy", tableName: "🌐AD&InAppPurchase"))
            .disabled(self.buyingInProgress)
            .buttonStyle(.borderedProminent)
            .overlay {
                if self.buyingInProgress { ProgressView() }
            }
            .alert(isPresented: self.$showError) {
                Alert(title: Text("Error", tableName: "🌐AD&InAppPurchase"),
                      message: Text(self.errorMessage),
                      dismissButton: .default(Text("OK", tableName: "🌐AD&InAppPurchase")))
            }
        }
        .padding(.vertical)
        .disabled(self.model.unconnected)
        .disabled(self.model.purchased)
        .animation(.default, value: self.model.purchased)
    }
}

private struct 🛒RestoreButton: View {
    @EnvironmentObject var model: 🛒InAppPurchaseModel
    @State private var restoringInProgress = false
    @State private var showAlert = false
    @State private var syncSuccess = false
    @State private var alertMessage = ""
    var body: some View {
        Section {
            Button {
                Task {
                    do {
                        self.restoringInProgress = true
                        try await AppStore.sync()
                        self.syncSuccess = true
                        self.alertMessage = "Restored transactions"
                    } catch {
                        print("Failed sync: \(error)")
                        self.syncSuccess = false
                        self.alertMessage = error.localizedDescription
                    }
                    self.showAlert = true
                    self.restoringInProgress = false
                }
            } label: {
                HStack {
                    Label(String(localized: "Restore Purchases", table: "🌐AD&InAppPurchase"),
                          systemImage: "arrow.clockwise")
                    .font(.footnote)
                    .foregroundColor(self.model.unconnected ? .secondary : nil)
                    .grayscale(self.model.purchased ? 1 : 0)
                    if self.restoringInProgress {
                        Spacer()
                        ProgressView()
                    }
                }
            }
            .disabled(self.restoringInProgress)
            .alert(isPresented: self.$showAlert) {
                Alert(title: Text(self.syncSuccess ? "Done" : "Error", tableName: "🌐AD&InAppPurchase"),
                      message: Text(LocalizedStringKey(self.alertMessage)),
                      dismissButton: .default(Text("OK", tableName: "🌐AD&InAppPurchase")))
            }
        }
    }
}
