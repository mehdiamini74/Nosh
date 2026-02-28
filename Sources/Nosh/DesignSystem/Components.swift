import SwiftUI

struct TagPill: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Capsule().fill(.thinMaterial))
            .accessibilityLabel("Tag \(text)")
    }
}

struct DealCard: View {
    let data: DealCardViewData

    var body: some View {
        GlassSurface {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(data.venue.name)
                            .font(.headline)
                        Text(data.venue.neighborhood)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Text(data.statusText)
                        .font(.caption.weight(.bold))
                        .foregroundStyle(data.deal.isLiveNow() ? .green : .orange)
                }

                Text(data.deal.title)
                    .font(.title3.weight(.semibold))
                Text(data.deal.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

                HStack {
                    Label(data.deal.displayWindow, systemImage: "clock")
                    Spacer()
                    Label(data.distance, systemImage: "location")
                }
                .font(.caption)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(data.deal.tags, id: \.self) { tag in
                            TagPill(text: tag)
                        }
                    }
                }
            }
        }
        .accessibilityElement(children: .combine)
    }
}
