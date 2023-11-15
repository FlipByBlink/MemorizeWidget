import SwiftUI

class 🔍SearchModel: ObservableObject {
    @AppStorage(🎛️Key.Search.leadingText) var inputtedLeadingText: String = ""
    @AppStorage(🎛️Key.Search.trailingText) var trailingText: String = ""
    func entireText(_ ⓠuery: String) -> String {
        "https://\(self.leadingText)\(ⓠuery)\(self.trailingText)"
    }
    func generateURL(_ ⓠuery: String) -> URL {
        guard let ⓔncodedText = Self.percentEncode(self.entireText(ⓠuery)),
              let ⓤrl = URL(string: ⓔncodedText) else {
            return Self.placeholderURL(ⓠuery)
        }
        💥Feedback.light()
        return ⓤrl
    }
    init() {
        Self.MigrationToVer_1_4.removeHttpScheme()
    }
}

private extension 🔍SearchModel {
    private var leadingText: String {
        if self.inputtedLeadingText.isEmpty {
            "duckduckgo.com/?q="
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
    private enum MigrationToVer_1_4 {
        static func removeHttpScheme() {
            if var source = UserDefaults.standard.string(forKey: 🎛️Key.Search.leadingText) {
                if source.hasPrefix("http://") {
                    source.trimPrefix("http://")
                } else if source.hasPrefix("https://") {
                    source.trimPrefix("https://")
                }
                UserDefaults.standard.set(source, forKey: 🎛️Key.Search.leadingText)
            }
        }
    }
}
