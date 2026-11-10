import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = JournalViewModel()

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
                        Image(systemName: "line.3.horizontal.decrease")
                        Image(systemName: "plus")
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
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.journals) { journal in
                                JournalCard(journal: journal)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
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
    }
}

#Preview {
    MainView()
}
