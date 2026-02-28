import SwiftUI

struct HottestView: View {
    @StateObject private var viewModel = HottestViewModel()

    var body: some View {
        ZStack {
            LinearGradient(colors: [.orange.opacity(0.45), .purple.opacity(0.35), .black.opacity(0.88)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            if viewModel.isLoading {
                ProgressView("Loading hottest deals...")
                    .tint(.white)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Hottest Happy Hours")
                            .font(.largeTitle.weight(.bold))
                            .padding(.horizontal)
                            .foregroundStyle(.white)

                        if viewModel.deals.isEmpty {
                            GlassSurface {
                                Text(viewModel.errorMessage ?? "No deals found")
                            }
                            .padding(.horizontal)
                        } else {
                            ForEach(viewModel.deals) { item in
                                NavigationLink(value: item) {
                                    DealCard(data: item)
                                        .padding(.horizontal)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .navigationDestination(for: DealCardViewData.self) { item in
            DealDetailView(data: item)
        }
        .task {
            await viewModel.load()
        }
    }
}
