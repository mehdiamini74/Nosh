import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            NavigationStack { HottestView() }
                .tabItem { Label("Hottest", systemImage: "flame.fill") }

            NavigationStack { PlaceholderView(title: "Explore", subtitle: "Search and categories arriving next.") }
                .tabItem { Label("Explore", systemImage: "magnifyingglass") }

            NavigationStack { PlaceholderView(title: "Map", subtitle: "Map-based discovery arriving next.") }
                .tabItem { Label("Map", systemImage: "map") }

            NavigationStack { PlaceholderView(title: "Saved", subtitle: "Your favorites will appear here.") }
                .tabItem { Label("Saved", systemImage: "bookmark.fill") }

            NavigationStack { PlaceholderView(title: "Profile", subtitle: "Manage preferences and membership.") }
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
        }
        .tint(.orange)
    }
}

struct PlaceholderView: View {
    let title: String
    let subtitle: String

    var body: some View {
        ZStack {
            LinearGradient(colors: [.orange.opacity(0.35), .blue.opacity(0.3), .black.opacity(0.85)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            GlassSurface {
                VStack(spacing: 10) {
                    Text(title)
                        .font(.largeTitle.weight(.bold))
                    Text(subtitle)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(24)
        }
    }
}
