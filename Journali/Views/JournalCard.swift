import SwiftUI

struct JournalCard: View {
    let journal: JournalEntry
    let onBookmark: () -> Void
    let onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(journal.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.appTitle)

                Spacer()

                Button {
                    onBookmark()
                } label: {
                    Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundStyle(Color.appTitle)
                        .padding(8)
                }
                .buttonStyle(.borderless)
            }

            Text(journal.date.formatted(date: .numeric, time: .omitted))
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(journal.content)
                .font(.subheadline)
                .foregroundStyle(.primary)
                .lineLimit(4)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.appCard, in: RoundedRectangle(cornerRadius: 20))
        .contentShape(RoundedRectangle(cornerRadius: 20))
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    JournalCard(
        journal: JournalEntry(title: "My Birthday", content: "Lorem ipsum dolor sit amet.", isBookmarked: true),
        onBookmark: {},
        onTap: {}
    )
    .padding()
    .preferredColorScheme(.dark)
}
