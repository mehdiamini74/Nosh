import Foundation

protocol SeedProviding {
    func loadSeed() async throws -> SeedPayload
}

enum SeedRepositoryError: Error {
    case missingFile
    case decodeFailed
}

final class SeedRepository: SeedProviding {
    func loadSeed() async throws -> SeedPayload {
        guard let url = Bundle.main.url(forResource: "vancouver_seed", withExtension: "json") else {
            throw SeedRepositoryError.missingFile
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        guard let payload = try? decoder.decode(SeedPayload.self, from: data) else {
            throw SeedRepositoryError.decodeFailed
        }
        return payload
    }
}
