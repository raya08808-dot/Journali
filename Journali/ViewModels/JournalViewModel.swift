import Foundation
import Combine

enum SortOption {
    case none, bookmark, date
}

class JournalViewModel: ObservableObject {
    @Published var journals: [JournalEntry] = []
    @Published var searchText = ""
    @Published var sortOption: SortOption = .none

    var filteredJournals: [JournalEntry] {
        var result = journals

        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }

        switch sortOption {
        case .bookmark:
            result = result.sorted { $0.isBookmarked && !$1.isBookmarked }
        case .date:
            result = result.sorted { $0.date > $1.date }
        case .none:
            break
        }

        return result
    }

    func addJournal(title: String, content: String) {
        let newJournal = JournalEntry(title: title, content: content)
        journals.append(newJournal)
    }

    func toggleBookmark(for journal: JournalEntry) {
        if let index = journals.firstIndex(where: { $0.id == journal.id }) {
            journals[index].isBookmarked.toggle()
        }
    }

    func deleteJournal(_ journal: JournalEntry) {
        journals.removeAll { $0.id == journal.id }
    }

    func updateJournal(_ journal: JournalEntry, title: String, content: String) {
        if let index = journals.firstIndex(where: { $0.id == journal.id }) {
            journals[index].title = title
            journals[index].content = content
        }
    }
}
