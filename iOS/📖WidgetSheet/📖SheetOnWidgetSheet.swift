import SwiftUI

enum 📖SheetOnWidgetSheet {
    case dictionary(UIReferenceLibraryViewController)
    case ad
}

extension 📖SheetOnWidgetSheet: Identifiable, Hashable {
    var id: Self { self }
    struct Handler: ViewModifier {
        @EnvironmentObject var appModel: 📱AppModel
        @EnvironmentObject var inAppPurchaseModel: 🛒InAppPurchaseModel
        func body(content: Content) -> some View {
            content
                .sheet(item: self.$appModel.presentedSheetOnWidgetSheet) {
                    switch $0 {
                        case .dictionary(let ⓥiewController): 📘DictionaryView(ⓥiewController)
                        case .ad: 📣ADContentView()
                    }
                }
        }
    }
}
