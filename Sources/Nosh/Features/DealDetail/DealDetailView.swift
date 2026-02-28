import SwiftUI

struct DealDetailView: View {
    let data: DealCardViewData
    @State private var isSaved = false

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ZStack(alignment: .bottomLeading) {
                    Rectangle()
                        .fill(LinearGradient(colors: [.orange, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))

                    GlassSurface {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(data.venue.name)
                                .font(.title2.weight(.bold))
                            Text(data.venue.neighborhood)
                                .foregroundStyle(.secondary)
                            Label(data.deal.displayWindow, systemImage: "clock")
                                .font(.caption)
                        }
                    }
                    .padding()
                }

                GlassSurface {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(data.deal.title)
                            .font(.headline)
                        Text(data.deal.description)
                        HStack {
                            Button("Get Directions") {}
                                .buttonStyle(.borderedProminent)
                            Button(isSaved ? "Saved" : "Save") { isSaved.toggle() }
                                .buttonStyle(.bordered)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Deal")
        .navigationBarTitleDisplayMode(.inline)
    }
}
