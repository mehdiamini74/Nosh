import SwiftUI

@main
struct NoshApp: App {
    @AppStorage("nosh.didOnboard") private var didOnboard = false

    var body: some Scene {
        WindowGroup {
            if didOnboard {
                RootTabView()
            } else {
                OnboardingView {
                    didOnboard = true
                }
            }
        }
    }
}
