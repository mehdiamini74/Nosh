import SwiftUI

struct OnboardingView: View {
    @State private var selectedCuisines: Set<String> = []
    @State private var maxDistance: Double = 5
    private let store = AppStorageStore()

    let onContinue: () -> Void

    private let cuisines = ["Seafood", "Japanese", "Italian", "Mexican", "Vegan", "Pub"]

    var body: some View {
        ZStack {
            LinearGradient(colors: [.pink.opacity(0.4), .indigo.opacity(0.45), .black], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Text("Welcome to Nosh")
                        .font(.largeTitle.weight(.bold))
                    Text("Find happy hour deals fast across Greater Vancouver.")
                        .font(.title3)
                        .foregroundStyle(.secondary)

                    GlassSurface {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Favorite cuisines")
                                .font(.headline)
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                                ForEach(cuisines, id: \.self) { cuisine in
                                    Button(cuisine) {
                                        if selectedCuisines.contains(cuisine) {
                                            selectedCuisines.remove(cuisine)
                                        } else {
                                            selectedCuisines.insert(cuisine)
                                        }
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .tint(selectedCuisines.contains(cuisine) ? .orange : .gray.opacity(0.35))
                                }
                            }
                        }
                    }

                    GlassSurface {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Distance radius: \(Int(maxDistance)) km")
                                .font(.headline)
                            Slider(value: $maxDistance, in: 1...25, step: 1)
                        }
                    }

                    Button("Continue") {
                        save()
                        onContinue()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)
                }
                .padding(20)
            }
        }
    }

    private func save() {
        var prefs = store.loadPreferences()
        prefs.cuisines = Array(selectedCuisines)
        prefs.maxDistanceKm = maxDistance
        store.save(preferences: prefs)
    }
}
