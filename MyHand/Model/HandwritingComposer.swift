import Foundation
import PencilKit
import SwiftUI

struct HandwritingComposer {
    // Tune these values to adjust spacing and layout.
    static let defaultAdvance: CGFloat = 55
    static let defaultLineHeight: CGFloat = 90
    static let defaultMargin: CGFloat = 30

    static func compose(text: String, glyphStore: GlyphStore, maxWidth: CGFloat) -> (drawing: PKDrawing, missing: [String]) {
        let normalized = text.lowercased()
        var x = defaultMargin
        var y = defaultMargin
        var missing = Set<String>()
        var strokes: [PKStroke] = []

        for character in normalized {
            if character == "\n" {
                x = defaultMargin
                y += defaultLineHeight
                continue
            }

            if character == " " {
                x += defaultAdvance
                if x > maxWidth {
                    x = defaultMargin
                    y += defaultLineHeight
                }
                continue
            }

            let key = String(character)
            if let data = glyphStore.loadGlyphData(for: key),
               let glyphDrawing = try? PKDrawing(data: data) {
                let transform = CGAffineTransform(translationX: x, y: y)
                let transformed = glyphDrawing.transformed(using: transform)
                strokes.append(contentsOf: transformed.strokes)
            } else {
                missing.insert(key)
            }

            x += defaultAdvance
            if x > maxWidth {
                x = defaultMargin
                y += defaultLineHeight
            }
        }

        let output = PKDrawing(strokes: strokes)
        let missingList = missing.sorted()
        return (output, missingList)
    }
}
