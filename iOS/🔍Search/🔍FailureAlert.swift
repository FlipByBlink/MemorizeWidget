import SwiftUI

struct 🔍FailureAlert: ViewModifier {
    @ObservedObject var model: 🔍SearchModel
    func body(content: Content) -> some View {
        content
            .alert("⚠️ Failed to open URL", isPresented: self.$model.alertOpenURLFailure) {
                Button("OK") {}
            } message: {
                Text("Change the URL")
            }
    }
    init(_ model: 🔍SearchModel) {
        self.model = model
    }
}
