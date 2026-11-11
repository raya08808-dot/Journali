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
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Button {
                    if hasChanges {
                        showDiscardAlert = true
                    } else {
                        dismissAction()
                    }
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.white)
                        .frame(width: 36, height: 36)
                        .background(Color(red: 0.2, green: 0.2, blue: 0.22), in: Circle())
                }

                Spacer()

                Button {
                    if let journal {
                        viewModel.updateJournal(journal, title: title, content: content)
                    } else {
                        viewModel.addJournal(title: title, content: content)
                    }
                    dismissAction()
                } label: {
                    Image(systemName: "checkmark")
                        .foregroundStyle(.white)
                        .frame(width: 36, height: 36)
                        .background(Color(red: 0.5, green: 0.51, blue: 1.0), in: Circle())
                }
            }

            TextField("Title", text: $title)
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(.white)

            Text((journal?.date ?? Date()).formatted(date: .numeric, time: .omitted))
                .font(.system(size: 14))
                .foregroundStyle(.gray)

            TextEditor(text: $content)
                .font(.system(size: 18))
                .foregroundStyle(.white)
                .scrollContentBackground(.hidden)
        }
        .padding()
        .background(Color(red: 0.11, green: 0.11, blue: 0.12))
        .confirmationDialog(
            "Are you sure you want to discard changes on this journal?",
            isPresented: $showDiscardAlert,
            titleVisibility: .visible
        ) {
            Button("Discard Changes", role: .destructive) {
                dismissAction()
            }
            Button("Keep Editing", role: .cancel) { }
        }
    }
}

#Preview {
    EditJournalView(viewModel: JournalViewModel())
}
