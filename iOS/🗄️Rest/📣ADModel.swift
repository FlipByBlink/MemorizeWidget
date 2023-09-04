import SwiftUI

enum 📣ADTargetApp: String, CaseIterable {
    case FlipByBlink
    case FadeInAlarm
    case PlainShogiBoard
    case TapWeight
    case TapTemperature
    case MemorizeWidget
    case LockInNote
    
    var localizationKey: LocalizedStringKey { .init(self.rawValue) }
    
    var url: URL {
        switch self {
            case .FlipByBlink: .init(string: "https://apps.apple.com/app/id1444571751")!
            case .FadeInAlarm: .init(string: "https://apps.apple.com/app/id1465336070")!
            case .PlainShogiBoard: .init(string: "https://apps.apple.com/app/id1620268476")!
            case .TapWeight: .init(string: "https://apps.apple.com/app/id1624159721")!
            case .TapTemperature: .init(string: "https://apps.apple.com/app/id1626760566")!
            case .MemorizeWidget: .init(string: "https://apps.apple.com/app/id1644276262")!
            case .LockInNote: .init(string: "https://apps.apple.com/app/id1644879340")!
        }
    }
    
    var mockImageName: String { "mock/" + self.rawValue }
    
    var iconImageName: String { "icon/" + self.rawValue }
    
    static func pickUpAppWithout(_ ⓜySelf: Self) -> Self { .allCases.filter({ $0 != ⓜySelf }).randomElement()! }
    
    var isHealthKitApp: Bool { [Self.TapTemperature, .TapWeight].contains(self) }
}
