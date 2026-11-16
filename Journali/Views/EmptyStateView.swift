import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(.soso2)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200)

            Text("Begin Your Journal")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(Color.appTitle)

            Text("Craft your personal diary, tap the plus icon to begin")
                .font(.callout)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 60)
        }
    }
}

#Preview {
    EmptyStateView()
        .preferredColorScheme(.dark)
}
