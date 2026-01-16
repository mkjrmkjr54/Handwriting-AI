import PencilKit
import SwiftUI

struct RenderView: View {
    @EnvironmentObject private var glyphStore: GlyphStore
    @State private var inputText: String = ""
    @State private var renderedDrawing = PKDrawing()
    @State private var missingGlyphs: [String] = []
    @State private var showShareSheet = false
    @State private var shareItems: [Any] = []

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 16) {
                TextEditor(text: $inputText)
                    .frame(height: 120)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.secondary))
                    .padding(.horizontal)

                HStack(spacing: 12) {
                    Button("Render") {
                        let maxWidth = max(proxy.size.width - 32, 300)
                        let result = HandwritingComposer.compose(
                            text: inputText,
                            glyphStore: glyphStore,
                            maxWidth: maxWidth
                        )
                        renderedDrawing = result.drawing
                        missingGlyphs = result.missing
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Export") {
                        if let image = Export.renderedImage(from: renderedDrawing) {
                            shareItems = [image]
                            showShareSheet = true
                        }
                    }
                    .buttonStyle(.bordered)
                    .disabled(renderedDrawing.bounds.isEmpty)
                }

                if !missingGlyphs.isEmpty {
                    Text("Missing glyphs: \(missingGlyphs.joined(separator: ", "))")
                        .foregroundColor(.orange)
                        .padding(.horizontal)
                }

                ScrollView([.vertical, .horizontal]) {
                    DrawingPreview(drawing: renderedDrawing)
                        .frame(height: 500)
                        .padding()
                }

                Spacer()
            }
            .sheet(isPresented: $showShareSheet) {
                ActivityView(activityItems: shareItems)
            }
        }
        .navigationTitle("Render")
    }
}
