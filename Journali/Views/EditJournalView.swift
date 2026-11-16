import SwiftUI

struct EditJournalView: View {
    @ObservedObject var viewModel: JournalViewModel
    @Environment(\.dismiss) private var dismissAction

    let journal: JournalEntry?

    @State private var title: String
    @State private var content: String
    @State private var showDiscardAlert = false

    init(viewModel: JournalViewModel, journal: JournalEntry? = nil) {
        self.viewModel = viewModel
        self.journal = journal
        _title = State(initialValue: journal?.title ?? "")
        _content = State(initialValue: journal?.content ?? "")
    }

    private var hasChanges: Bool {
        title != (journal?.title ?? "") || content != (journal?.content ?? "")
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                TextField("Title", text: $title)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text((journal?.date ?? Date()).formatted(date: .numeric, time: .omitted))
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                ZStack(alignment: .topLeading) {
                    TextEditor(text: $content)
                        .scrollContentBackground(.hidden)

                    if content.isEmpty {
                        Text("Type your Journal...")
                            .foregroundStyle(.secondary)
                            .padding(.top, 8)
                            .padding(.leading, 5)
                            .allowsHitTesting(false)
                    }
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        if hasChanges {
                            showDiscardAlert = true
                        } else {
                            dismissAction()
                        }
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if let journal {
                            viewModel.updateJournal(journal, title: title, content: content)
                        } else {
                            viewModel.addJournal(title: title, content: content)
                        }
                        dismissAction()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .tint(.appAccent)
                }
            }
            .alert(
                "Are you sure you want to discard changes on this journal?",
                isPresented: $showDiscardAlert
            ) {
                Button("Discard Changes", role: .destructive) {
                    dismissAction()
                }
                Button("Keep Editing", role: .cancel) { }
            }
        }
    }
}

#Preview {
    EditJournalView(viewModel: JournalViewModel())
        .preferredColorScheme(.dark)
}
