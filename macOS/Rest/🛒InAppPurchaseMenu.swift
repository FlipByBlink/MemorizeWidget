import SwiftUI
import StoreKit

struct 🛒InAppPurchaseMenu: View {
    var body: some View {
        List {
            Self.aboutADSection()
            Section {
                GroupBox {
                    VStack {
                        Self.PurchaseView()
                        Self.adPreview()
                        Self.RestoreButton()
                    }
                    .padding()
                }
            } header: {
                Text("In-App Purchase", tableName: "🌐AD&InAppPurchase")
            }
            .headerProminence(.increased)
        }
        .navigationTitle(.init("In-App Purchase", tableName: "🌐AD&InAppPurchase"))
        .frame(minWidth: 400, minHeight: 640)
    }
}

private extension 🛒InAppPurchaseMenu {
    private static func aboutADSection() -> some View {
        Section {
            GroupBox {
                Text("This App shows advertisement about applications on App Store. These are several Apps by this app's developer. It is activated after you launch this app 5 times.",
                     tableName: "🌐AD&InAppPurchase")
                .padding()
            }
        } header: {
            Text("About AD", tableName: "🌐AD&InAppPurchase")
        }
    }
    private static func adPreview() -> some View {
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
        .padding(12)
    }
    private struct PurchaseView: View {
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
                .accessibilityLabel(.init("Buy", tableName: "🌐AD&InAppPurchase"))
                .disabled(self.buyingInProgress)
                .buttonStyle(.borderedProminent)
                .overlay {
                    if self.buyingInProgress { ProgressView() }
                }
                .alert(isPresented: self.$showError) {
                    Alert(title: .init("Error", tableName: "🌐AD&InAppPurchase"),
                          message: .init(self.errorMessage),
                          dismissButton: .default(.init("OK", tableName: "🌐AD&InAppPurchase")))
                }
            }
            .disabled(self.model.unconnected)
            .disabled(self.model.purchased)
            .animation(.default, value: self.model.purchased)
        }
    }
    private struct RestoreButton: View {
        @EnvironmentObject var model: 🛒InAppPurchaseModel
        @State private var restoringInProgress = false
        @State private var showAlert = false
        @State private var syncSuccess = false
        @State private var alertMessage = ""
        var body: some View {
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
                Label(String(localized: "Restore Purchases", table: "🌐AD&InAppPurchase"),
                      systemImage: "arrow.clockwise")
                .font(.subheadline)
                .foregroundColor(self.model.unconnected ? .secondary : nil)
                .grayscale(self.model.purchased ? 1 : 0)
                .overlay {
                    if self.restoringInProgress { ProgressView() }
                }
            }
            .disabled(self.restoringInProgress)
            .alert(isPresented: self.$showAlert) {
                Alert(title: .init(self.syncSuccess ? "Done" : "Error", tableName: "🌐AD&InAppPurchase"),
                      message: .init(LocalizedStringKey(self.alertMessage)),
                      dismissButton: .default(.init("OK", tableName: "🌐AD&InAppPurchase")))
            }
        }
    }
}
