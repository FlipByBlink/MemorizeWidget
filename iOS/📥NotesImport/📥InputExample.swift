import SwiftUI

struct 📥InputExample: View {
    @Binding var mode: 📥InputMode
    var body: some View {
        Section {
            switch self.mode {
                case .file:
                    HStack {
                        Image("sample_numbers")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .shadow(radius: 2)
                        Image(systemName: "arrow.right")
                            .font(.title2.weight(.semibold))
                        Image("sample_importedNotes")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .shadow(radius: 2)
                    }
                    .frame(maxHeight: 220)
                    .padding(.horizontal, 8)
                    .padding(.vertical)
                    Image("numbers_csv_tsv_export")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .frame(maxHeight: 200)
                        .shadow(radius: 2)
                        .padding()
                    Image("sample_txt_macTextEdit")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .frame(maxHeight: 200)
                        .shadow(radius: 2)
                        .padding()
                case .text:
                    HStack {
                        Image("sample_appleNotes")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .shadow(radius: 2)
                        Image(systemName: "arrow.right")
                            .font(.title2.weight(.semibold))
                        Image("sample_importedNotes")
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
