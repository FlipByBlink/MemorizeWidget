enum 📚TextConvert {
    enum Separator: String {
        case tab = "\t"
        case comma = ","
        case titleOnly = ""
    }
    static func decode(_ ⓘnputText: String, _ ⓢeparator: Self.Separator) -> 📚Notes {
        var ⓝotes: 📚Notes = []
        let ⓞneLineTexts: [String] = ⓘnputText.components(separatedBy: .newlines)
        ⓞneLineTexts.forEach { ⓞneLine in
            if !ⓞneLine.isEmpty {
                if ⓢeparator == .titleOnly {
                    ⓝotes.append(📗Note(ⓞneLine))
                } else {
                    let ⓣexts = ⓞneLine.components(separatedBy: ⓢeparator.rawValue)
                    if let ⓣitle = ⓣexts.first {
                        if !ⓣitle.isEmpty {
                            let ⓒomment = ⓞneLine.dropFirst(ⓣitle.count + 1).description
                            ⓝotes.append(📗Note(ⓣitle, ⓒomment))
                        }
                    }
                }
            }
        }
        return ⓝotes
    }
    static func encodeToTSV(_ ⓝotes: 📚Notes) -> String {
        ⓝotes.reduce(into: "") { ⓟartialResult, ⓝote in
            var ⓣempNote = ⓝote
            ⓣempNote.title.removeAll(where: { $0 == "\n" })
            ⓣempNote.comment.removeAll(where: { $0 == "\n" })
            ⓟartialResult += ⓣempNote.title + "\t" + ⓣempNote.comment
            if ⓝote != ⓝotes.last { ⓟartialResult += "\n" }
        }
    }
}
