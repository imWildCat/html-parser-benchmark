@testable import HTMLParserBenchmarkSwift
import SwiftSoup
import XCTest

struct WikipediaExpectation {
    let title: String
    let charset: String
}

final class HTMLParserBenchmarkSwiftTests: XCTestCase {
    func testSwiftSoup() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        let htmlContent = try loadWikipediaHTML()
        let expectations = try loadExpectations()

        let doc: Document = try SwiftSoup.parse(htmlContent)

        let start = Date()

        for _ in 0 ..< 10_000 {
            let titleElement = try doc.select("title").first()!
            XCTAssertEqual(try titleElement.text(), expectations.title)

            let metaCharsetElement = try doc.select("meta[charset]").first()!
            let charset = try metaCharsetElement.attr("charset")
            XCTAssertEqual(charset, expectations.charset)
        }

        let end = Date()

        print("Duration:" + String(end.timeIntervalSince(start) * 1000) + "ms")
    }

    func loadWikipediaHTML() throws -> String {
        return try String(contentsOf: Bundle.module.url(forResource: "wikipedia_on_wikipedia", withExtension: "html")!)
    }

    func loadExpectations() throws -> WikipediaExpectation {
        let title = try String(contentsOfFile: "../fixtures/wikipedia/title.txt", encoding: .utf8)
        let charset = try String(contentsOfFile: "../fixtures/wikipedia/charset.txt", encoding: .utf8)
        return WikipediaExpectation(title: title, charset: charset)
    }
}
