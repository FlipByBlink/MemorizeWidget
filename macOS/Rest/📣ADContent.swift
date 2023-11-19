import SwiftUI

struct 📣ADContent: View {
    @EnvironmentObject var model: 🛒InAppPurchaseModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.openWindow) var openWindow
    @State private var disableDismiss: Bool = true
    private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    @State private var countDown: Int
    private var targetApp: 📣ADTargetApp
    var body: some View {
        VStack {
            self.header()
            HStack(spacing: 16) {
                self.mockImage()
                VStack(spacing: 16) {
                    Spacer()
                    self.appIcon()
                    self.appName()
                    self.appDescription()
                    Spacer()
                    self.appStoreBadge()
                    Spacer()
                }
                .padding(8)
            }
            .padding(32)
            .modifier(Self.PurchasedEffect())
        }
        .frame(width: 700, height: 430)
        .onChange(of: self.model.purchased) { if $0 { self.disableDismiss = false } }
        .onReceive(self.timer) { _ in
            if self.countDown > 1 {
                self.countDown -= 1
            } else {
                self.disableDismiss = false
            }
        }
    }
    init(_ app: 📣ADTargetApp, second: Int) {
        self.targetApp = app
        self._countDown = State(initialValue: second)
    }
}

private extension 📣ADContent {
    private func header() -> some View {
        HStack {
            self.dismissButton()
            Text(verbatim: "\(self.countDown)")
                .foregroundStyle(.tertiary)
                .font(.subheadline)
                .opacity(self.disableDismiss ? 1 : 0)
            Spacer()
            self.menuLink()
        }
        .overlay {
            Text("AD", tableName: "🌐AD&InAppPurchase")
                .font(.headline)
        }
        .padding(.top, 12)
        .padding(.horizontal, 18)
        .animation(.default, value: self.disableDismiss)
    }
    private func mockImage() -> some View {
        Link(destination: self.targetApp.url) {
            Image(self.targetApp.mockImageName)
                .resizable()
                .scaledToFit()
        }
        .accessibilityHidden(true)
        .disabled(self.model.purchased)
    }
    private func appIcon() -> some View {
        Link(destination: self.targetApp.url) {
            HStack(spacing: 16) {
                Image(self.targetApp.iconImageName)
                    .resizable()
                    .frame(width: 80, height: 80)
                if self.targetApp.isHealthKitApp {
                    Image(.appleHealthBadge)
                }
            }
        }
        .accessibilityHidden(true)
        .disabled(self.model.purchased)
    }
    private func appName() -> some View {
        Link(destination: self.targetApp.url) {
            Text(self.targetApp.localizationKey, tableName: "🌐ADAppName")
                .font(.title.bold())
        }
        .buttonStyle(.plain)
        .accessibilityHidden(true)
        .disabled(self.model.purchased)
    }
    private func appDescription() -> some View {
        Text(self.targetApp.localizationKey, tableName: "🌐ADAppDescription")
            .font(.title3)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 8)
    }
    private func appStoreBadge() -> some View {
        Link(destination: self.targetApp.url) {
            HStack(spacing: 6) {
                Image(.appstoreBadge)
                Image(systemName: "hand.point.up.left")
            }
            .foregroundColor(.primary)
        }
        .accessibilityLabel(.init("Open App Store page", tableName: "🌐AD&InAppPurchase"))
        .disabled(self.model.purchased)
    }
    private func menuLink() -> some View {
        Button {
            self.openWindow(id: "InAppPurchase")
        } label: {
            Image(systemName: "questionmark")
        }
        .accessibilityLabel(.init("About AD", tableName: "🌐AD&InAppPurchase"))
        .help(.init("About AD", tableName: "🌐AD&InAppPurchase"))
    }
    private func dismissButton() -> some View {
        Button {
            if !self.disableDismiss { self.dismiss() }
        } label: {
            Image(systemName: "xmark")
                .fontWeight(.medium)
        }
        .opacity(self.disableDismiss ? 0.33 : 1)
        .accessibilityLabel(.init("Dismiss", tableName: "🌐AD&InAppPurchase"))
        .keyboardShortcut(.cancelAction)
    }
    private struct PurchasedEffect: ViewModifier {
        @EnvironmentObject var model: 🛒InAppPurchaseModel
        func body(content: Content) -> some View {
            if self.model.purchased {
                content
                    .blur(radius: 6)
                    .overlay {
                        Image(systemName: "trash.square.fill")
                            .resizable()
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, .red)
                            .frame(width: 160, height: 160)
                            .rotationEffect(.degrees(5))
                            .shadow(radius: 8)
                    }
            } else {
                content
            }
        }
    }
}

//シート上のAssetsのImageを読み込むと以下のログが出る
//>This method should not be called on the main thread as it may lead to UI unresponsiveness.
