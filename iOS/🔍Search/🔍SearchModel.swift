import SwiftUI

class 🔍SearchModel: ObservableObject {
    @AppStorage("SearchLeadingText") var inputtedLeadingText: String = ""
    @AppStorage("SearchTrailingText") var trailingText: String = ""
    func entireText(_ ⓠuery: String) -> String {
        self.leadingText + ⓠuery + self.trailingText
    }
    func generateURL(_ ⓠuery: String) -> URL {
        guard let ⓔncodedText = Self.percentEncode(self.entireText(ⓠuery)),
              let ⓤrl = URL(string: ⓔncodedText) else {
            return Self.placeholderURL(ⓠuery)
        }
        💥Feedback.light()
        return ⓤrl
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
