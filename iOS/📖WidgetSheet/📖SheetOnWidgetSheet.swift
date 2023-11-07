import SwiftUI

enum 📖SheetOnWidgetSheet {
    case dictionary(UIReferenceLibraryViewController)
    case ad
}

extension 📖SheetOnWidgetSheet: Identifiable, Hashable {
    var id: Self { self }
    struct Handler: ViewModifier {
        @EnvironmentObject var model: 📱AppModel
        @EnvironmentObject var inAppPurchaseModel: 🛒InAppPurchaseModel
        func body(content: Content) -> some View {
            content
                .sheet(item: self.$model.presentedSheetOnWidgetSheet) {
                    switch $0 {
                        case .dictionary(let viewController): 📘DictionaryView(viewController)
                        case .ad: 📣ADContentView()
                    }
                }
                .task {
                    try? await Task.sleep(for: .seconds(1))
                    if self.inAppPurchaseModel.checkToShowADSheet() {
                        self.model.presentedSheetOnWidgetSheet = .ad
                    }
                }
        }
    }
}
