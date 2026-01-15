import Foundation

enum FileStorage {
    static func glyphsDirectory() -> URL {
        let base = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        let directory = base.appendingPathComponent("Glyphs", isDirectory: true)
        if !FileManager.default.fileExists(atPath: directory.path) {
            try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        }
        return directory
    }

    static func glyphURL(for key: String) -> URL {
        let safeKey = key.replacingOccurrences(of: "/", with: "_")
        return glyphsDirectory().appendingPathComponent("\(safeKey).pkdraw")
    }

    static func saveGlyphData(_ data: Data, for key: String) {
        let url = glyphURL(for: key)
        do {
            try data.write(to: url, options: [.atomic])
        } catch {
            print("Failed to save glyph \(key): \(error)")
        }
    }

    static func loadAllGlyphs() -> [String: Data] {
        let directory = glyphsDirectory()
        guard let contents = try? FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil) else {
            return [:]
        }

        var glyphs: [String: Data] = [:]
        for file in contents where file.pathExtension == "pkdraw" {
            let key = file.deletingPathExtension().lastPathComponent
            if let data = try? Data(contentsOf: file) {
                glyphs[key] = data
            }
        }
        return glyphs
    }
}
