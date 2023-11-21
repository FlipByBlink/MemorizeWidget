import SwiftUI

class 🔍SearchModel: ObservableObject {
    @AppStorage(🎛️Key.Search.leadingText)
    var inputtedLeadingText: String = ""
    
    @AppStorage(🎛️Key.Search.trailingText)
    var trailingText: String = ""
    
    @AppStorage(🎛️Key.Search.openURLInOtherApp)
    var openURLInOtherApp: Bool = 🎛️Default.Search.openURLInOtherApp
    
    @Published var alertOpenURLFailure: Bool = false
}

extension 🔍SearchModel {
    func entireText(_ ⓠuery: String) -> String {
        "\(self.leadingText)\(ⓠuery)\(self.trailingText)"
    }
    func generateURL(_ ⓠuery: String) -> URL {
        guard let ⓔncodedText = Self.percentEncode(self.entireText(ⓠuery)),
              let ⓤrl = URL(string: ⓔncodedText) else {
            return Self.placeholderURL(ⓠuery)
        }
        💥Feedback.light()
        return ⓤrl
    }
    var ableInAppSearch: Bool {
        if self.openURLInOtherApp {
            true
        } else {
            if self.inputtedLeadingText.hasPrefix("http://")
                || self.inputtedLeadingText.hasPrefix("https://") {
                true
            } else {
                if self.inputtedLeadingText.isEmpty,
                   self.trailingText.isEmpty {
                    true
                } else {
                    false
                }
            }
        }
    }
}

private extension 🔍SearchModel {
    private var leadingText: String {
        if self.inputtedLeadingText.isEmpty {
            "https://duckduckgo.com/?q="
        } else {
            self.inputtedLeadingText
        }
    }
    private static func percentEncode(_ ⓣext: String) -> String? {
        ⓣext.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    private static func placeholderURL(_ ⓠuery: String) -> URL {
        .init(string: "https://duckduckgo.com/?q=\(ⓠuery)")!
    }
}
