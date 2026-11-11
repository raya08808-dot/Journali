import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = JournalViewModel()
    @State private var showAddSheet = false
    @State private var journalToDelete: JournalEntry?
    @State private var journalToEdit: JournalEntry?

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack {
                HStack {
                    Text("Journal")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(.white)

                    Spacer()

                    HStack(spacing: 20) {
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

                        Button {
                            showAddSheet = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    .font(.system(size: 18))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color(red: 0.11, green: 0.11, blue: 0.12), in: Capsule())
                }
                .padding(.horizontal)

                if viewModel.journals.isEmpty {
                    Spacer()
                    EmptyStateView()
                    Spacer()
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
                                .tint(Color(red: 0.99, green: 0.27, blue: 0.24))
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $viewModel.searchText)
                    Spacer()
                    Image(systemName: "mic.fill")
                }
                .foregroundStyle(.gray)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(red: 0.11, green: 0.11, blue: 0.12), in: Capsule())
                .padding(.horizontal)
            }
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
}
