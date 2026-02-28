import Foundation
import CoreLocation

struct City: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let region: String
    let defaultMapRegion: MapRegionDTO
}

struct MapRegionDTO: Codable, Hashable {
    let latitude: Double
    let longitude: Double
    let latitudeDelta: Double
    let longitudeDelta: Double
}

struct Venue: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let coordinates: Coordinates
    let neighborhood: String
    let cuisineTags: [String]
    let priceLevel: Int
    let images: [String]
    let phone: String
    let website: URL?
    let reservationURL: URL?

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
}

struct Coordinates: Codable, Hashable {
    let latitude: Double
    let longitude: Double
}

struct Deal: Codable, Identifiable, Hashable {
    let id: String
    let venueId: String
    let title: String
    let description: String
    let dealType: DealType
    let startTime: String
    let endTime: String
    let daysOfWeek: [Int]
    let isExclusive: Bool
    let tags: [String]
    let lastUpdated: Date

    enum DealType: String, Codable, CaseIterable {
        case happyHour
        case earlyBird
        case tacoTuesday
        case oysters
        case beerSpecial
        case lateNight
    }

    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }

    func isLiveNow(referenceDate: Date = .now, calendar: Calendar = .current) -> Bool {
        guard daysOfWeek.contains(calendar.component(.weekday, from: referenceDate)) else { return false }
        guard let start = timeFormatter.date(from: startTime), let end = timeFormatter.date(from: endTime) else { return false }

        let startComps = calendar.dateComponents([.hour, .minute], from: start)
        let endComps = calendar.dateComponents([.hour, .minute], from: end)
        guard let todayStart = calendar.date(bySettingHour: startComps.hour ?? 0, minute: startComps.minute ?? 0, second: 0, of: referenceDate),
              let todayEnd = calendar.date(bySettingHour: endComps.hour ?? 0, minute: endComps.minute ?? 0, second: 0, of: referenceDate) else {
            return false
        }

        return referenceDate >= todayStart && referenceDate <= todayEnd
    }

    func startsLaterToday(referenceDate: Date = .now, calendar: Calendar = .current) -> Bool {
        guard daysOfWeek.contains(calendar.component(.weekday, from: referenceDate)) else { return false }
        guard let start = timeFormatter.date(from: startTime) else { return false }
        let comps = calendar.dateComponents([.hour, .minute], from: start)
        guard let todayStart = calendar.date(bySettingHour: comps.hour ?? 0, minute: comps.minute ?? 0, second: 0, of: referenceDate) else {
            return false
        }
        return todayStart > referenceDate
    }

    var displayWindow: String {
        guard let start = timeFormatter.date(from: startTime), let end = timeFormatter.date(from: endTime) else {
            return "Times unavailable"
        }
        let displayFormatter = DateFormatter()
        displayFormatter.timeStyle = .short
        return "\(displayFormatter.string(from: start)) – \(displayFormatter.string(from: end))"
    }
}

struct Review: Codable, Identifiable, Hashable {
    let id: String
    let venueId: String
    let rating: Int
    let text: String
    let authorName: String
    let createdAt: Date
}

struct UserPreferences: Codable, Hashable {
    var cuisines: [String]
    var dietary: [String]
    var vibes: [String]
    var maxDistanceKm: Double
    var notificationSettings: NotificationSettings
    var homeCityId: String

    static let `default` = UserPreferences(
        cuisines: [],
        dietary: [],
        vibes: [],
        maxDistanceKm: 5,
        notificationSettings: .default,
        homeCityId: "vancouver"
    )
}

struct NotificationSettings: Codable, Hashable {
    var nearbyDeals: Bool
    var favoritesOnly: Bool
    var dailyDigest: Bool

    static let `default` = NotificationSettings(nearbyDeals: true, favoritesOnly: true, dailyDigest: false)
}

struct SavedItem: Codable, Identifiable, Hashable {
    var id: String { venueId }
    let venueId: String
    var dealIds: [String]
    let createdAt: Date
}

struct SeedPayload: Codable {
    let cities: [City]
    let venues: [Venue]
    let deals: [Deal]
    let reviews: [Review]
}

extension CLLocationDistance {
    func asKmString() -> String {
        let km = self / 1_000
        return String(format: "%.1f km", km)
    }
}
