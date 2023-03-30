import SwiftUI

struct 📖NoteSheet: View {
    @EnvironmentObject var 📱: 📱AppModel
    @EnvironmentObject var 🛒: 🛒StoreModel
    @Environment(\.dismiss) var dismiss
    @State private var 🚩showADMenuSheet: Bool = false
    @FocusState private var 🔍commentFocus: Bool
    private var 🔢noteIndex: Int? {
        📱.📚notes.firstIndex { $0.id.uuidString == 📱.🆔openedNoteID }
    }
    var body: some View {
        NavigationView {
            GeometryReader { 📐 in
                VStack {
                    Spacer()
                    if let 🔢noteIndex {
                        TextField("No title", text: $📱.📚notes[🔢noteIndex].title)
                            .font(.title.bold())
                            .multilineTextAlignment(.center)
                            .accessibilityHidden(true)
                        TextEditor(text: $📱.📚notes[🔢noteIndex].comment)
                            .focused(self.$🔍commentFocus)
                            .multilineTextAlignment(.center)
                            .font(.title3.weight(.light))
                            .foregroundStyle(.secondary)
                            .frame(minHeight: 50, maxHeight: 180)
                            .accessibilityHidden(true)
                            .overlay(alignment: .top) {
                                if 📱.📚notes[🔢noteIndex].comment.isEmpty {
                                    Text("No comment")
                                        .foregroundStyle(.quaternary)
                                        .padding(6)
                                        .allowsHitTesting(false)
                                }
                            }
                            .overlay(alignment: .bottomTrailing) {
                                if self.🔍commentFocus {
                                    Button {
                                        self.🔍commentFocus = false
                                        UISelectionFeedbackGenerator().selectionChanged()
                                    } label: {
                                        Label("Done", systemImage: "checkmark.circle.fill")
                                            .font(.largeTitle)
                                            .symbolRenderingMode(.hierarchical)
                                            .labelStyle(.iconOnly)
                                    }
                                    .foregroundStyle(.tertiary)
                                    .padding(8)
                                }
                            }
                        Spacer()
                        HStack(spacing: 36) {
                            Button(role: .destructive) {
                                📱.📚notes.remove(at: 🔢noteIndex)
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            } label: {
                                Label("Delete", systemImage: "trash")
                                    .font(.title3.bold())
                                    .foregroundStyle(.secondary)
                                    .labelStyle(.iconOnly)
                            }
                            .tint(.red)
                            📗SystemDictionaryButton(🔢noteIndex)
                                .font(.title3.weight(.semibold))
                                .foregroundStyle(.tertiary)
                            🔍SearchButton(🔢noteIndex)
                                .font(.title3.weight(.semibold))
                                .foregroundStyle(.tertiary)
                        }
                        .padding()
                    } else {
                        HStack {
                            Spacer()
                            VStack(spacing: 24) {
                                Label("Deleted.", systemImage: "checkmark")
                                Image(systemName: "trash")
                            }
                            .imageScale(.small)
                            .font(.largeTitle)
                            .padding(.bottom, 48)
                            Spacer()
                        }
                    }
                    Spacer()
                    if 📐.size.height > 500 {
                        📣ADView(without: .MemorizeWidget, self.$🚩showADMenuSheet)
                            .frame(height: 160)
                    }
                }
                .modifier(📣ADMenuSheet(self.$🚩showADMenuSheet))
                .animation(.default.speed(1.5), value: self.🔢noteIndex)
                .padding(24)
                .toolbar {
                    Button {
                        self.dismiss()
                        UISelectionFeedbackGenerator().selectionChanged()
                    } label: {
                        Image(systemName: "chevron.down")
                    }
                    .tint(.secondary)
                    .accessibilityLabel("Dismiss")
                }
            }
        }
    }
}
