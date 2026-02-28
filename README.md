# Nosh iOS MVP

Nosh is a SwiftUI-first iPhone app for discovering happy hour deals and restaurant discounts in Greater Vancouver.

## Build & run

1. Open `Package.swift` in Xcode 15+ (or newer).
2. Select an iOS simulator (iPhone 15+ recommended).
3. Run the `Nosh` scheme.

> Note: this repository is scaffolded as a Swift Package app target so it can be opened directly in Xcode.

## Architecture overview

- `Sources/Nosh/App`: app entry, onboarding gate, tab routing.
- `Sources/Nosh/DesignSystem`: reusable Liquid Glass-inspired surfaces and UI components.
- `Sources/Nosh/Features`: feature folders (`Hottest`, `DealDetail`, placeholders for Explore/Map/Saved/Profile/Onboarding).
- `Sources/Nosh/Data`
  - `Models`: core entities (`City`, `Venue`, `Deal`, etc.) and computed helpers.
  - `Repositories`: seed loader and repository protocols.
  - `Persistence`: local preferences storage for onboarding.
- `Sources/Nosh/Services`: reserved for location and notifications.
- `Sources/Nosh/Resources`: local seed JSON (`vancouver_seed.json`) with 20 venues and 40 deals.

## Backend integration points (next)

- Replace `SeedRepository` with `RemoteDealRepository` using `URLSession`.
- Suggested endpoints:
  - `GET /cities/{id}/venues`
  - `GET /cities/{id}/deals?day=&liveNow=&radius=`
  - `GET /venues/{id}`
  - `GET /venues/{id}/reviews`
  - `GET /users/{id}/saved`
  - `PUT /users/{id}/preferences`

## Next steps

1. Authentication and account sync.
2. Multi-city switcher with region-aware data caching.
3. Real reservations integration (OpenTable/Resy/direct booking links).
4. Exclusive Offers with StoreKit purchase flow.
5. Review moderation + reporting tools.
6. Analytics and experimentation (search funnels, save/favorite conversion).
7. Push notifications pipeline (APNs + relevance scoring).
