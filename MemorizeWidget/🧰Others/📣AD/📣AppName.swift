
import SwiftUI

enum 📣AppName: String, CaseIterable, Identifiable {
    case FlipByBlink
    case FadeInAlarm
    case Plain将棋盤
    case TapWeight
    case TapTemperature
    
    var id: String { self.rawValue }
    
    var 🔗URL: URL {
        switch self {
            case .FlipByBlink: return URL(string: "https://apps.apple.com/app/id1444571751")!
            case .FadeInAlarm: return URL(string: "https://apps.apple.com/app/id1465336070")!
            case .Plain将棋盤: return URL(string: "https://apps.apple.com/app/id1620268476")!
            case .TapWeight: return URL(string: "https://apps.apple.com/app/id1624159721")!
            case .TapTemperature: return URL(string: "https://apps.apple.com/app/id1626760566")!
        }
    }
    
    var 📄About: LocalizedStringKey {
        switch self {
            case .FlipByBlink:
                return "Simple and normal ebook reader (for fixed-layout). Only a special feature. Turn a page with slightly longish voluntary blink."
                
            case .FadeInAlarm:
                return "Alarm clock with taking a long time from small volume to max volume."
                
            case .Plain将棋盤:
                return "Simple Shogi board App. Based on iOS system UI design."
                
            case .TapWeight:
                return "Register weight data to the Apple \"Health\" application pre-installed on iPhone in the fastest possible way (as manual)."
                
            case .TapTemperature:
                return "Register body temperature data to the \"Health\" app pre-installed on iPhone in the fastest possible way (as manual)."
        }
    }
}
