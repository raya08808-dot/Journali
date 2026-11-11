import SwiftUI

struct JournalCard: View {
    let journal: JournalEntry
    let onBookmark: () -> Void
    let onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(journal.title)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(Color(red: 0.69, green: 0.6, blue: 0.99))

                Spacer()

                Button {
                    onBookmark()
                } label: {
                    Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundStyle(Color(red: 0.69, green: 0.6, blue: 0.99))
                        .padding(8)
                }
                .buttonStyle(.borderless)
            }

            Text(journal.date.formatted(date: .numeric, time: .omitted))
                .font(.system(size: 12))
                .foregroundStyle(.gray)

            Text(journal.content)
                .font(.system(size: 14))
                .foregroundStyle(.white)
                .lineLimit(4)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 0.11, green: 0.11, blue: 0.12), in: RoundedRectangle(cornerRadius: 20))
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
    .background(Color.black)
}
