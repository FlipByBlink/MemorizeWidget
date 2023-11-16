import SwiftUI

struct 📥InputExample: View {
    @EnvironmentObject var model: 📥NotesImportModel
    var body: some View {
        Section {
            switch self.model.inputMode {
                case .file:
                    HStack {
                        Image(.sampleNumbers)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .shadow(radius: 2)
                        Image(systemName: "arrow.right")
                            .font(.title2.weight(.semibold))
                        Image(.sampleImportedNotes)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .shadow(radius: 2)
                    }
                    .frame(maxHeight: 220)
                    .padding(.horizontal, 8)
                    .padding(.vertical)
                    Image(.numbersCsvTsvExport)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .frame(maxHeight: 200)
                        .shadow(radius: 2)
                        .padding()
                    Image(.sampleTxtMacTextEdit)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .frame(maxHeight: 200)
                        .shadow(radius: 2)
                        .padding()
                case .text:
                    HStack {
                        Image(.sampleAppleNotes)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .shadow(radius: 2)
                        Image(systemName: "arrow.right")
                            .font(.title2.weight(.semibold))
                        Image(.sampleImportedNotes)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .shadow(radius: 2)
                    }
                    .frame(maxHeight: 200)
                    .padding(.horizontal, 8)
                    .padding(.vertical)
            }
        } header: {
            Text("Example")
        }
    }
}
