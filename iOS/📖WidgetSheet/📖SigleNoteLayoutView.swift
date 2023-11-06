import SwiftUI

struct 📖SigleNoteLayoutView: View {
    @EnvironmentObject var model: 📱AppModel
    private var ⓘndex: Int? {
        self.model.notes.index(
            self.model.presentedSheetOnContentView?.widgetInfo?.targetedNoteIDs?.first
        )
    }
    var body: some View {
        VStack {
            Spacer()
            if let ⓘndex {
                📗NoteView(self.$model.notes[ⓘndex], layout: .widgetSheet_single)
                    .padding(.horizontal, 32)
                Spacer()
                HStack {
                    Spacer()
                    📖DictionaryButton(self.model.notes[ⓘndex])
                    Spacer()
                    🔍SearchButton(self.model.notes[ⓘndex])
                    Spacer()
                    🚮DeleteNoteButton(self.model.notes[ⓘndex])
                    Spacer()
                }
                .labelStyle(.iconOnly)
                .buttonStyle(.plain)
                .foregroundColor(.primary)
                .font(.title)
                .padding(.horizontal, 24)
            } else {
                📖DeletedNoteView()
                    .padding(.bottom, 24)
            }
            Spacer()
        }
    }
}
