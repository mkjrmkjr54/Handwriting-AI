import PencilKit
import SwiftUI

struct CaptureView: View {
    @EnvironmentObject private var glyphStore: GlyphStore
    @State private var selectedGlyph: GlyphOption = GlyphOption.defaults.first!
    @State private var drawing = PKDrawing()

    var body: some View {
        VStack(spacing: 16) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(GlyphOption.defaults) { option in
                        Button {
                            selectedGlyph = option
                            loadSelectedGlyph()
                        } label: {
                            HStack(spacing: 6) {
                                Text(option.display)
                                    .font(.headline)
                                    .frame(width: 32, height: 32)
                                    .background(option == selectedGlyph ? Color.accentColor.opacity(0.2) : Color.clear)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))

                                if glyphStore.hasGlyph(for: option.value) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                }
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 6)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }

            PencilCanvasView(drawing: $drawing)
                .frame(height: 320)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)

            HStack(spacing: 12) {
                Button("Save") {
                    glyphStore.saveGlyph(drawing: drawing, for: selectedGlyph.value)
                }
                .buttonStyle(.borderedProminent)

                Button("Clear") {
                    drawing = PKDrawing()
                }
                .buttonStyle(.bordered)
            }

            Spacer()
        }
        .navigationTitle("Capture")
        .onAppear {
            loadSelectedGlyph()
        }
    }

    private func loadSelectedGlyph() {
        if let data = glyphStore.loadGlyphData(for: selectedGlyph.value),
           let loadedDrawing = try? PKDrawing(data: data) {
            drawing = loadedDrawing
        } else {
            drawing = PKDrawing()
        }
    }
}

struct GlyphOption: Identifiable, Equatable {
    let id = UUID()
    let display: String
    let value: String

    static let defaults: [GlyphOption] = {
        var options: [GlyphOption] = []
        let letters = (UnicodeScalar("a").value...UnicodeScalar("z").value)
            .compactMap { UnicodeScalar($0) }
            .map { String($0) }
        options.append(contentsOf: letters.map { GlyphOption(display: $0, value: $0) })
        options.append(GlyphOption(display: "␣", value: " "))
        let punctuation = [".", ",", "!", "?", "'", ":", ";", "-", "(", ")"]
        options.append(contentsOf: punctuation.map { GlyphOption(display: $0, value: $0) })
        return options
    }()
}
