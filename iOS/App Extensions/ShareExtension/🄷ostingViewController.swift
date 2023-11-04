import UIKit
import SwiftUI

class 🄷ostingViewController: UIHostingController<🄼ainView> {
    private let 📨 = 📨ShareExtensionModel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: 🄼ainView(self.📨))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.📨.setUp(extensionContext)
    }
}

struct 🄼ainView: View {
    @ObservedObject var 📨: 📨ShareExtensionModel
    var body: some View {
        NavigationStack {
            List {
                switch 📨.type {
                    case .textFile:
                        self.ⓢeparatorPicker()
                        self.ⓝotesListView()
                    case .improperFile:
                        Label("Not text file(UTF-8).", systemImage: "exclamationmark.triangle")
                            .foregroundStyle(.secondary)
                    case .selectedText:
                        if 📨.importSelectedTextAsSingleNote {
                            TextField("No title", text: $📨.singleNote.title)
                            TextField("No comment", text: $📨.singleNote.comment)
                                .foregroundStyle(.secondary)
                            if 📨.singleNote.title.contains("\n") {
                                Section {
                                    Button {
                                        withAnimation {
                                            📨.importSelectedTextAsSingleNote = false
                                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                        }
                                    } label: {
                                        ZStack {
                                            Color.clear
                                            Label("Import as some notes.", systemImage: "books.vertical")
                                                .font(.subheadline)
                                        }
                                    }
                                    .listRowBackground(Color.clear)
                                    .foregroundStyle(.secondary)
                                }
                            }
                        } else {
                            self.ⓢeparatorPicker()
                            self.ⓝotesListView()
                        }
                    case .exceedDataLimitation:
                        VStack {
                            Text("⚠️ Data size limitation")
                                .font(.headline)
                            Text("Total notes data over 800kB. Please decrease notes.")
                                .font(.subheadline)
                        }
                        .padding(.vertical, 8)
                    case .none:
                        if ProcessInfo().isiOSAppOnMac {
                            Text("Selected text import is not supported on macOS.")
                        } else {
                            Text(verbatim: "🐛 Bug")
                        }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                        📨.storeNotes()
                        📨.extensionContext?.completeRequest(returningItems: nil)
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .disabled(📨.type == .improperFile)
                    .disabled(📨.type == .exceedDataLimitation)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        📨.extensionContext?.completeRequest(returningItems: nil)
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .tint(.red)
                }
            }
        }
        .animation(.default, value: 📨.separator)
    }
    private func ⓢeparatorPicker() -> some View {
        Section {
            Picker(selection: $📨.separator) {
                Text("Tab ␣ ")
                    .tag(🅂eparator.tab)
                    .accessibilityLabel("Tab")
                Text("Comma , ")
                    .tag(🅂eparator.comma)
                    .accessibilityLabel("Comma")
                Text("(Title only)")
                    .tag(🅂eparator.titleOnly)
                    .accessibilityLabel("Title only")
            } label: {
                Label("Separator", systemImage: "arrowtriangle.left.and.line.vertical.and.arrowtriangle.right")
            }
        }
    }
    private func ⓝotesListView() -> some View {
        ForEach(📨.convertedNotes) { ⓝote in
            VStack(alignment: .leading) {
                Text(ⓝote.title)
                Text(ⓝote.comment)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 8)
        }
    }
    init(_ 📨: 📨ShareExtensionModel) {
        self.📨 = 📨
    }
}
