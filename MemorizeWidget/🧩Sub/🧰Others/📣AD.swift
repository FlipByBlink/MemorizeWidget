import SwiftUI
import StoreKit

//struct 📣ADSheet: ViewModifier {
//    @EnvironmentObject var 🛒: 🛒StoreModel
//    @State private var ⓐpp: 📣MyApp = .pickUpAppWithout(.ONESELF)
//    func body(content: Content) -> some View {
//        content
//            .sheet(isPresented: $🛒.🚩showADSheet) { 📣ADView(self.ⓐpp) }
//            .onAppear { 🛒.checkToShowADSheet() }
//    }
//}

struct 📣ADView: View {
    @EnvironmentObject var 🛒: 🛒StoreModel
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State private var 🚩disableDismiss: Bool = true
    private let 🕒timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    @State private var 🕒countdown: Int
    private var ⓐpp: 📣MyApp
    var body: some View {
        Group {
            if #available(iOS 16.0, *) {
                NavigationStack { self.ⓒontent() }
                    .presentationDetents([.height(640)])
            } else {
                NavigationView { self.ⓒontent() }
                    .navigationViewStyle(.stack)
            }
        }
        .onChange(of: self.scenePhase) {
            if $0 == .background { 🛒.🚩showADSheet = false }
        }
        .interactiveDismissDisabled(self.🚩disableDismiss)
        .onReceive(self.🕒timer) { _ in
            if self.🕒countdown > 1 {
                self.🕒countdown -= 1
            } else {
                self.🚩disableDismiss = false
            }
        }
    }
    private func ⓒontent() -> some View {
        Group {
            if self.verticalSizeClass == .regular {
                self.ⓥerticalLayout()
            } else {
                self.ⓗorizontalLayout()
            }
        }
        .modifier(Self.ⓟurchasedEffect())
        .navigationTitle("AD")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                self.ⓓismissButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                self.ⓐdMenuLink()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    private func ⓥerticalLayout() -> some View {
        VStack(spacing: 16) {
            Spacer(minLength: 0)
            self.ⓜockImage()
            Spacer(minLength: 0)
            self.ⓘcon()
            self.ⓝame()
            Spacer(minLength: 0)
            self.ⓓescription()
            Spacer(minLength: 0)
            self.ⓐppStoreBadge()
            Spacer(minLength: 0)
        }
        .padding()
    }
    private func ⓗorizontalLayout() -> some View {
        HStack(spacing: 16) {
            self.ⓜockImage()
            VStack(spacing: 12) {
                Spacer()
                self.ⓘcon()
                self.ⓝame()
                self.ⓓescription()
                Spacer()
                self.ⓐppStoreBadge()
                Spacer()
            }
            .padding(.horizontal)
        }
        .padding()
    }
    private func ⓜockImage() -> some View {
        Link(destination: self.ⓐpp.url) {
            Image(self.ⓐpp.mockImageName)
                .resizable()
                .scaledToFit()
        }
        .accessibilityHidden(true)
        .disabled(🛒.🚩purchased)
    }
    private func ⓘcon() -> some View {
        Link(destination: self.ⓐpp.url) {
            HStack(spacing: 16) {
                Image(self.ⓐpp.iconImageName)
                    .resizable()
                    .frame(width: 60, height: 60)
                if self.ⓐpp.isHealthKitApp {
                    Image("apple_health_badge")
                }
            }
        }
        .accessibilityHidden(true)
        .disabled(🛒.🚩purchased)
    }
    private func ⓝame() -> some View {
        Link(destination: self.ⓐpp.url) {
            Text(self.ⓐpp.name)
                .font(.headline)
        }
        .buttonStyle(.plain)
        .accessibilityHidden(true)
        .disabled(🛒.🚩purchased)
    }
    private func ⓓescription() -> some View {
        Text(self.ⓐpp.description)
            .font(.subheadline)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 8)
    }
    private func ⓐppStoreBadge() -> some View {
        Link(destination: self.ⓐpp.url) {
            HStack(spacing: 6) {
                Image("appstore_badge")
                Image(systemName: "hand.point.up.left")
            }
            .foregroundColor(.primary)
        }
        .accessibilityLabel("Open AppStore page")
        .disabled(🛒.🚩purchased)
    }
    private func ⓐdMenuLink() -> some View {
        NavigationLink {
            📣ADMenu()
                .navigationBarTitleDisplayMode(.large)
        } label: {
            Image(systemName: "questionmark.circle")
                .foregroundColor(.primary)
        }
        .accessibilityLabel("About AD")
    }
    private func ⓓismissButton() -> some View {
        Button {
            🛒.🚩showADSheet = false
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            if self.🚩disableDismiss {
                Image(systemName: "\(self.🕒countdown.description).circle")
            } else {
                Image(systemName: "xmark.circle.fill")
                    .font(.body.weight(.medium))
            }
        }
        .foregroundStyle(self.🚩disableDismiss ? .tertiary : .primary)
        .disabled(self.🚩disableDismiss)
        .animation(.default, value: self.🚩disableDismiss)
        .accessibilityLabel("Dismiss")
    }
    private struct ⓟurchasedEffect: ViewModifier {
        @EnvironmentObject var 🛒: 🛒StoreModel
        func body(content: Content) -> some View {
            if 🛒.🚩purchased {
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
    init(_ app: 📣MyApp, second: Int) {
        self.ⓐpp = app
        self._🕒countdown = State(initialValue: second)
    }
}

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

private struct 📣ADMenu: View {
    @EnvironmentObject var 🛒: 🛒StoreModel
    var body: some View {
        List {
            Section {
                Text("This App shows advertisement about applications on AppStore. These are several Apps by this app's developer. It is activated after you launch this app 5 times.")
                    .padding()
            } header: {
                Text("Description")
            }
            🛒IAPSection()
        }
        .navigationTitle("About AD")
    }
}

enum 📣MyApp: String, CaseIterable {
    case FlipByBlink
    case FadeInAlarm
    case PlainShogiBoard
    case TapWeight
    case TapTemperature
    case MemorizeWidget
    case LockInNote
    
    var name: LocalizedStringKey { LocalizedStringKey(self.rawValue) }
    
    var url: URL {
        switch self {
            case .FlipByBlink: return URL(string: "https://apps.apple.com/app/id1444571751")!
            case .FadeInAlarm: return URL(string: "https://apps.apple.com/app/id1465336070")!
            case .PlainShogiBoard: return URL(string: "https://apps.apple.com/app/id1620268476")!
            case .TapWeight: return URL(string: "https://apps.apple.com/app/id1624159721")!
            case .TapTemperature: return URL(string: "https://apps.apple.com/app/id1626760566")!
            case .MemorizeWidget: return URL(string: "https://apps.apple.com/app/id1644276262")!
            case .LockInNote: return URL(string: "https://apps.apple.com/app/id1644879340")!
        }
    }
    
    var description: LocalizedStringKey {
        switch self {
            case .FlipByBlink: return "E-book reader that can turn a page with slightly longish voluntary blink."
            case .FadeInAlarm: return "Alarm clock with taking a long time from small volume to max volume."
            case .PlainShogiBoard: return "Simplest Shogi board App. Supported SharePlay."
            case .TapWeight: return "Register weight data to \"Health\" app pre-installed on iPhone in the fastest way (as manual)."
            case .TapTemperature: return "Register body temperature data to \"Health\" app pre-installed on iPhone in the fastest way (as manual)."
            case .MemorizeWidget: return "Flashcard on widget. Memorize a note in everyday life."
            case .LockInNote: return "Notes widget on lock screen."
        }
    }
    
    var mockImageName: String { "mock/" + self.rawValue }
    
    var iconImageName: String { "icon/" + self.rawValue }
    
    static func pickUpAppWithout(_ ⓜySelf: Self) -> Self {
        let ⓐpps = 📣MyApp.allCases.filter { $0 != ⓜySelf }
        return ⓐpps.randomElement()!
    }
    
    var isHealthKitApp: Bool {
        self == .TapTemperature || self == .TapWeight
    }
}
