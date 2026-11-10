import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(.soso2)
                .resizable()
                .scaledToFit()
                .frame(width: 160)

            Text("Begin Your Journal")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(Color(red: 0.69, green: 0.6, blue: 0.99))

            Text("Craft your personal diary, tap the plus icon to begin")
                .font(.system(size: 16, weight: .light))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .frame(width: 250)
        }
    }
}

#Preview {
    EmptyStateView()
        .preferredColorScheme(.dark)
}
