import Foundation
import CoreLocation

@MainActor
final class HottestViewModel: ObservableObject {
    @Published private(set) var deals: [DealCardViewData] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?

    private let seedRepository: SeedProviding

    init(seedRepository: SeedProviding = SeedRepository()) {
        self.seedRepository = seedRepository
    }

    func load() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let seed = try await seedRepository.loadSeed()
            let venuesById = Dictionary(uniqueKeysWithValues: seed.venues.map { ($0.id, $0) })

            deals = seed.deals
                .filter { $0.isLiveNow() || $0.startsLaterToday() }
                .sorted(by: { $0.startTime < $1.startTime })
                .compactMap { deal in
                    guard let venue = venuesById[deal.venueId] else { return nil }
                    return DealCardViewData(venue: venue, deal: deal)
                }

            if deals.isEmpty {
                errorMessage = "No deals right now. Try widening filters in Explore."
            }
        } catch {
            errorMessage = "Unable to load deals. Please retry."
        }
    }
}

struct DealCardViewData: Identifiable, Hashable {
    let venue: Venue
    let deal: Deal
    var id: String { deal.id }

    var statusText: String {
        if deal.isLiveNow() { return "Live now" }
        if deal.startsLaterToday() { return "Starts \(deal.displayWindow.components(separatedBy: " – ").first ?? "soon")" }
        return deal.displayWindow
    }

    var distance: String {
        CLLocation(latitude: 49.2827, longitude: -123.1207)
            .distance(from: CLLocation(latitude: venue.coordinates.latitude, longitude: venue.coordinates.longitude))
            .asKmString()
    }
}
