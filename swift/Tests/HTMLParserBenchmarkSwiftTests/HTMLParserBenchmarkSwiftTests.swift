import XCTest
@testable import HTMLParserBenchmarkSwift

final class HTMLParserBenchmarkSwiftTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(HTMLParserBenchmarkSwift().text, "Hello, World!")
    }

    func testParse() throws {
        let benchmark = HTMLParserBenchmarkSwift()

        try benchmark.parse()
    }
}
