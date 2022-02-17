// Created 2/13/22

import SwiftSoup
import Foundation

public struct HTMLParserBenchmarkSwift {
    public private(set) var text = "Hello, World!"

    public init() {}

    func parse() throws {
        let html = "<html><head><title>First parse</title></head>"
            + "<body><p>Parsed HTML into a doc.</p></body></html>"
        let doc: Document = try SwiftSoup.parse(html)
        try doc.text()
    }
}
