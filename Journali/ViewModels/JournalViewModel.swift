import Foundation
import Combine

class JournalViewModel: ObservableObject {
    @Published var journals: [JournalEntry] = []
}
