import SwiftUI

struct 🔩MainMenu: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        List {
            self.randomModeSection()
            Section {
                🎛️ViewComponent.MultiNotesToggle()
                Self.CommentOnWidgetSection()
                Self.FontSizeMenu()
            } header: {
                Text("Widget")
            }
            self.trashMenuLink()
            self.deleteAllNotesButton()
        }
        .navigationTitle("Menu")
    }
}

private extension 🔩MainMenu {
    private func randomModeSection() -> some View {
        Section {
            🎛️RandomModeToggle()
        } footer: {
            🎛️RandomModeToggle.Caption()
        }
    }
    private struct CommentOnWidgetSection: View {
        @AppStorage(🎛️Key.multiNotesMode, store: .ⓐppGroup) var multiNotesMode: Bool = false
        var body: some View {
            🎛️ViewComponent.ShowCommentToggle()
                .disabled(self.multiNotesMode)
        }
    }
    private func trashMenuLink() -> some View {
        Section {
            NavigationLink {
                🗑TrashMenu()
            } label: {
                LabeledContent {
                    Text(verbatim: "\(self.model.trash.deletedContents.count)")
                } label: {
                    Label("Trash", systemImage: "trash")
                }
            }
        }
    }
    private struct FontSizeMenu: View {
        @AppStorage(🎛️Key.FontSize.AccessoryFamily.title, store: .ⓐppGroup) var titleValue: Int = 14
        @AppStorage(🎛️Key.FontSize.AccessoryFamily.comment, store: .ⓐppGroup) var commentValue: Int = 9
        var body: some View {
            Section {
                NavigationLink {
                    List {
                        Section {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(.white)
                                    .shadow(color: .gray, radius: 3)
                                VStack(spacing: 2) {
                                    Text(verbatim: "(TITLE)")
                                        .font(.system(size: CGFloat(self.titleValue), weight: .bold))
                                        .foregroundStyle(.purple)
                                    Text(verbatim: "(Comment)")
                                        .font(.system(size: CGFloat(self.commentValue), weight: .light))
                                        .foregroundStyle(.green)
                                }
                            }
                            .frame(height: 72) //TODO: 実際のサイズに近付ける
                            .listRowBackground(Color.clear)
                            .animation(.default, value: self.titleValue)
                            .animation(.default, value: self.commentValue)
                        } header: {
                            Text("Preview")
                        }
                        Section {
                            🎛️ViewComponent.FontSize.TitleForAccessoryFamilyPicker()
                            🎛️ViewComponent.FontSize.CommentForAccessoryFamilyPicker()
                        } footer: {
                            Text("環境やテキストによって実際に表示されるサイズは変化します")
                        }
                    }
                    .navigationTitle("Font size")
                } label: {
                    Label("Customize font size", systemImage: "textformat.size")
                }
            }
        }
    }
    private func deleteAllNotesButton() -> some View {
        Section {
            🚮DeleteAllNotesButton()
                .modifier(🚮DeleteAllNotesButton.ConfirmDialog())
        }
    }
}
