import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.black, Color(red: 0.08, green: 0.08, blue: 0.1)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 8) {
                Image(.soso)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .padding(.bottom, 10)

                Text("Journali")
                    .font(.system(size: 42, weight: .black))
                    .foregroundStyle(.white)

                Text("Your thoughts, your story")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    SplashView()
}
