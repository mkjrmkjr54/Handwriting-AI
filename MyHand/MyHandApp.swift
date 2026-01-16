import SwiftUI

@main
struct MyHandApp: App {
    @StateObject private var glyphStore = GlyphStore()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(glyphStore)
        }
    }
}
