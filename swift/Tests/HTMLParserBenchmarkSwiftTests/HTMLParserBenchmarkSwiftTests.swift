import Kanna
import SwiftSoup
import XCTest

struct WikipediaExpectation {
    let title: String
    let charset: String
}

final class HTMLParserBenchmarkSwiftTests: XCTestCase {
    private enum Constants {
        static let repeatTime = 10_000
    }

    private var buildPath: String {
        FileManager.default.currentDirectoryPath + "/.build"
    }

    func testSwiftSoup() throws {
        let htmlContent = try loadWikipediaHTML()
        let expectations = try loadExpectations()

        let doc: Document = try SwiftSoup.parse(htmlContent)

        let start = Date()

        for _ in 0 ..< Constants.repeatTime {
            let titleElement = try doc.select("title").first()!
            XCTAssertEqual(try titleElement.text(), expectations.title)

            let metaCharsetElement = try doc.select("meta[charset]").first()!
            let charset = try metaCharsetElement.attr("charset")
            XCTAssertEqual(charset, expectations.charset)
        }

        let end = Date()
        let duration = end.timeIntervalSince(start) * 1000
        let durationString = String(format: "%.2f", duration)
        print("[SwiftSoup] Duration:" + durationString + "ms")
        try durationString.write(toFile: buildPath + "/swiftsoup.txt", atomically: true, encoding: .utf8)
    }

    func testKanna() throws {
        let htmlContent = try loadWikipediaHTML()
        let expectations = try loadExpectations()

        let doc: HTMLDocument = try Kanna.HTML(html: htmlContent, encoding: .utf8)

        let start = Date()

        for _ in 0 ..< Constants.repeatTime {
            let titleElement = doc.css("title").first!
            XCTAssertEqual(titleElement.text!, expectations.title)

            let metaCharsetElement = doc.css("meta[charset]").first!
            let charset = metaCharsetElement["charset"]!
            XCTAssertEqual(charset, expectations.charset)
        }

        let end = Date()
        let duration = end.timeIntervalSince(start) * 1000
        let durationString = String(format: "%.2f", duration)

        try durationString.write(toFile: buildPath + "/kanna.txt", atomically: true, encoding: .utf8)

        print("[Kanna] Duration:" + durationString + "ms")
    }

    func loadWikipediaHTML() throws -> String {
        return try String(contentsOf: Bundle.module.url(forResource: "wikipedia_on_wikipedia", withExtension: "html")!)
    }

    func loadExpectations() throws -> WikipediaExpectation {
        let title = try String(contentsOf: Bundle.module.url(forResource: "title", withExtension: "txt")!)
        let charset = try String(contentsOf: Bundle.module.url(forResource: "charset", withExtension: "txt")!)
        return WikipediaExpectation(title: title, charset: charset)
    }
}
