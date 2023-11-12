import SwiftUI

enum 📖SheetOnWidgetSheet {
    case dictionary(UIReferenceLibraryViewController)
    case ad
}

extension 📖SheetOnWidgetSheet: Identifiable, Hashable {
    var id: Self { self }
    struct Handler: ViewModifier {
        @EnvironmentObject var model: 📱AppModel
        func body(content: Content) -> some View {
            content
                .sheet(item: self.$model.presentedSheetOnWidgetSheet) {
                    switch $0 {
                        case .dictionary(let ⓥiewController): 📘DictionarySheetView(ⓥiewController)
                        case .ad: 📣ADContentView()
                    }
                }
        }
    }
}
