import SwiftUI

struct 📖SingleNoteLayoutView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        VStack {
            Spacer()
            if let ⓘndex = self.model.openedWidgetSingleNoteIndex {
//                📗NoteView(source: self.$model.notes[ⓘndex],
//                           titleFont: .largeTitle,
//                           commentFont: .title,
//                           placement: .widgetSheet)
                VStack {
                    Text(self.model.notes[ⓘndex].title)
                    Text(self.model.notes[ⓘndex].comment)
                }
                .padding(.horizontal, 32)
                Spacer()
                HStack {
                    Spacer()
//                    📖DictionaryButton(self.model.notes[ⓘndex])
                    Spacer()
//                    📖SearchButton(self.model.notes[ⓘndex])
                    Spacer()
                    if !self.model.randomMode {
//                        📖MoveEndButton(self.model.notes[ⓘndex])
                        Spacer()
                    }
//                    🚮DeleteNoteButton(self.model.notes[ⓘndex])
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
