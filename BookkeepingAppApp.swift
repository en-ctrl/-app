import SwiftUI

@main
struct BookkeepingAppApp: App {
    @StateObject private var store = BookkeepingStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
