import PencilKit
import SwiftUI
import UIKit

enum Export {
    static func renderedImage(from drawing: PKDrawing) -> UIImage? {
        guard !drawing.bounds.isEmpty else { return nil }
        let padding: CGFloat = 20
        let rect = drawing.bounds.insetBy(dx: -padding, dy: -padding)
        return drawing.image(from: rect, scale: 2)
    }
}

struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No update needed.
    }
}
