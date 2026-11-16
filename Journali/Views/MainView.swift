import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = JournalViewModel()
    @State private var showAddSheet = false
    @State private var journalToDelete: JournalEntry?
    @State private var journalToEdit: JournalEntry?

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.journals.isEmpty {
                    EmptyStateView()
                } else {
                    List {
                        ForEach(viewModel.filteredJournals) { journal in
                            JournalCard(
                                journal: journal,
                                onBookmark: {
                                    viewModel.toggleBookmark(for: journal)
                                },
                                onTap: {
                                    journalToEdit = journal
                                }
                            )
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button {
                                    journalToDelete = journal
                                } label: {
                                    Image(systemName: "trash.fill")
                                }
                                .tint(.appDestructive)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Journal")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button("Sort by Bookmark") {
                            viewModel.sortOption = .bookmark
                        }
                        Button("Sort by Entry Date") {
                            viewModel.sortOption = .date
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .searchable(text: $viewModel.searchText)
        }
        .sheet(isPresented: $showAddSheet) {
            EditJournalView(viewModel: viewModel)
        }
        .sheet(item: $journalToEdit) { journal in
            EditJournalView(viewModel: viewModel, journal: journal)
        }
        .alert("Delete Journal?", isPresented: Binding(
            get: { journalToDelete != nil },
            set: { if !$0 { journalToDelete = nil } }
        )) {
            Button("Cancel", role: .cancel) {
                journalToDelete = nil
            }
            Button("Delete", role: .destructive) {
                if let journal = journalToDelete {
                    viewModel.deleteJournal(journal)
                }
                journalToDelete = nil
            }
        } message: {
            Text("Are you sure you want to delete this journal?")
        }
    }
}

#Preview {
    MainView()
        .preferredColorScheme(.dark)
}
