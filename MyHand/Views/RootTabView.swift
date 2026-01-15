import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                CaptureView()
            }
            .tabItem {
                Label("Capture", systemImage: "pencil.tip")
            }

            NavigationStack {
                RenderView()
            }
            .tabItem {
                Label("Render", systemImage: "text.bubble")
            }
        }
    }
}
