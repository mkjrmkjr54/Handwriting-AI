import Foundation
import PencilKit

final class GlyphStore: ObservableObject {
    @Published private(set) var glyphs: [String: Data] = [:]

    init() {
        loadGlyphs()
    }

    func hasGlyph(for key: String) -> Bool {
        glyphs[key] != nil
    }

    func loadGlyphData(for key: String) -> Data? {
        glyphs[key]
    }

    func saveGlyph(drawing: PKDrawing, for key: String) {
        let data = drawing.dataRepresentation()
        glyphs[key] = data
        FileStorage.saveGlyphData(data, for: key)
    }

    private func loadGlyphs() {
        glyphs = FileStorage.loadAllGlyphs()
    }
}
