import PencilKit
import SwiftUI

struct PencilCanvasView: UIViewRepresentable {
    @Binding var drawing: PKDrawing
    var isReadOnly: Bool = false

    func makeUIView(context: Context) -> PKCanvasView {
        let canvasView = PKCanvasView()
        canvasView.backgroundColor = UIColor.secondarySystemBackground
        canvasView.drawing = drawing
        canvasView.isOpaque = true
        canvasView.drawingPolicy = isReadOnly ? .default : .pencilOnly
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 4)
        canvasView.isUserInteractionEnabled = !isReadOnly
        canvasView.delegate = context.coordinator
        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        if uiView.drawing != drawing {
            uiView.drawing = drawing
        }
        uiView.isUserInteractionEnabled = !isReadOnly
        uiView.drawingPolicy = isReadOnly ? .default : .pencilOnly
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, PKCanvasViewDelegate {
        private let parent: PencilCanvasView

        init(_ parent: PencilCanvasView) {
            self.parent = parent
        }

        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            parent.drawing = canvasView.drawing
        }
    }
}
