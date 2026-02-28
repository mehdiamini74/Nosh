import Foundation

protocol PreferencesStoring {
    func loadPreferences() -> UserPreferences
    func save(preferences: UserPreferences)
}

final class AppStorageStore: PreferencesStoring {
    private let defaults: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "nosh.user.preferences"

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func loadPreferences() -> UserPreferences {
        guard let data = defaults.data(forKey: key),
              let prefs = try? decoder.decode(UserPreferences.self, from: data) else {
            return .default
        }
        return prefs
    }

    func save(preferences: UserPreferences) {
        guard let data = try? encoder.encode(preferences) else { return }
        defaults.set(data, forKey: key)
    }
}
