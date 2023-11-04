import SwiftUI

//struct 📣ADSheet: ViewModifier {
//    @EnvironmentObject var model: 🛒InAppPurchaseModel
//    @State private var app: 📣ADTargetApp = .pickUpAppWithout(.ONESELF)
//    @State private var showSheet: Bool = false
//    func body(content: Content) -> some View {
//        content
//            .sheet(isPresented: self.$showSheet) { 📣ADView(self.app) }
//            .onAppear { if self.model.checkToShowADSheet() { self.showSheet = true } }
//    }
//}

struct 📣ADView: View {
    @EnvironmentObject var model: 🛒InAppPurchaseModel
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.dismiss) var dismiss
    @State private var disableDismiss: Bool = true
    private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    @State private var countDown: Int
    private var targetApp: 📣ADTargetApp
    @State private var showMenu: Bool = false
    var body: some View {
        NavigationStack { self.appADContent() }
            .presentationDetents([.height(640)])
            .onChange(of: self.scenePhase) {
                if $0 == .background { self.dismiss() }
            }
            .onChange(of: self.model.purchased) { if $0 { self.disableDismiss = false } }
            .interactiveDismissDisabled(self.disableDismiss)
            .onReceive(self.timer) { _ in
                if self.countDown > 1 {
                    self.countDown -= 1
                } else {
                    self.disableDismiss = false
                }
            }
            .overlay(alignment: .top) { self.header() }
    }
    init(_ app: 📣ADTargetApp, second: Int) {
        self.targetApp = app
        self._countDown = State(initialValue: second)
    }
}

private extension 📣ADView {
    private func header() -> some View {
        HStack {
            if !self.showMenu {
                self.dismissButton()
                Spacer()
                self.menuLink()
            }
        }
        .font(.title3)
        .padding(.horizontal, 4)
        .animation(.default, value: self.disableDismiss)
        .animation(.default, value: self.showMenu)
    }
    private func appADContent() -> some View {
        Group {
            if self.verticalSizeClass == .compact {
                self.horizontalLayout()
            } else {
                self.verticalLayout()
            }
        }
        .modifier(Self.PurchasedEffect())
        .navigationTitle(.init("AD", tableName: "🌐AD&InAppPurchase"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: self.$showMenu) { 🛒InAppPurchaseMenu() }
    }
    private func verticalLayout() -> some View {
        VStack(spacing: 16) {
            Spacer(minLength: 0)
            self.mockImage()
            Spacer(minLength: 0)
            self.appIcon()
            self.appName()
            Spacer(minLength: 0)
            self.appDescription()
            Spacer(minLength: 0)
            self.appStoreBadge()
            Spacer(minLength: 0)
        }
        .padding()
    }
    private func horizontalLayout() -> some View {
        HStack(spacing: 16) {
            self.mockImage()
            VStack(spacing: 12) {
                Spacer()
                self.appIcon()
                self.appName()
                self.appDescription()
                Spacer()
                self.appStoreBadge()
                Spacer()
            }
            .padding(.horizontal)
        }
        .padding()
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
                    .frame(width: 60, height: 60)
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
                .font(.headline)
        }
        .buttonStyle(.plain)
        .accessibilityHidden(true)
        .disabled(self.model.purchased)
    }
    private func appDescription() -> some View {
        Text(self.targetApp.localizationKey, tableName: "🌐ADAppDescription")
            .font(.subheadline)
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
        .accessibilityLabel(Text("Open App Store page", tableName: "🌐AD&InAppPurchase"))
        .disabled(self.model.purchased)
    }
    private func menuLink() -> some View {
        Button {
            self.showMenu = true
        } label: {
            Image(systemName: "questionmark.circle")
                .padding(12)
        }
        .tint(.primary)
        .accessibilityLabel(.init("About AD", tableName: "🌐AD&InAppPurchase"))
    }
    private func dismissButton() -> some View {
        Group {
            if self.disableDismiss {
                Image(systemName: "\(self.countDown).circle")
                    .foregroundStyle(.tertiary)
                    .padding(12)
            } else {
                Button {
                    self.dismiss()
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .fontWeight(.medium)
                        .padding(12)
                }
                .keyboardShortcut(.cancelAction)
                .tint(.primary)
                .accessibilityLabel(.init("Dismiss", tableName: "🌐AD&InAppPurchase"))
            }
        }
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
