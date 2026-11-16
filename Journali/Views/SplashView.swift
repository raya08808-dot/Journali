import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(.soso)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 120)
                .padding(.bottom)

            Text("Journali")
                .font(.system(.largeTitle, weight: .black))

            Text("Your thoughts, your story")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    SplashView()
        .preferredColorScheme(.dark)
}
