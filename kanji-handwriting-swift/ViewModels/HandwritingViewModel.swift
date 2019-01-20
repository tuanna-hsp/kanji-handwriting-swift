
import Foundation

class HandwritingViewModel {
    
    var resultUpdated: (() -> Void)?
    
    private var characters = [String]() {
        didSet {
            resultUpdated?()
        }
    }
    
    private var allStrokes = [[NSValue]]()
    private var processedStrokeCount = 0
    private var recognizer: Recognizer?

    init(canvas: UIView) {
        recognizer = Recognizer(canvas: canvas)
    }

    func add(_ stroke: [NSValue]) {
        allStrokes.append(stroke)
        recognize()
    }
    
    func add(_ strokes: [[NSValue]]) {
        allStrokes.append(contentsOf: strokes)
        recognize()
    }
    
    func clear() {
        allStrokes.removeAll()
        processedStrokeCount = 0
        characters = [String]()
        recognizer?.clear()
    }
    
    func resultCount() -> Int {
        return characters.count
    }
    
    func result(atIndex: Int) -> String {
        return characters[atIndex]
    }
    
    private func recognize() {
        var results: [Result]?
        for index in (processedStrokeCount..<allStrokes.count) {
            results = recognizer?.classify(allStrokes[index])
            processedStrokeCount += 1
        }

        if results != nil {
            characters = results!.map { $0.value }
        }
    }
}
