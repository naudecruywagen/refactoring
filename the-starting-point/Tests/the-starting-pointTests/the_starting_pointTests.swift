import XCTest
@testable import the_starting_point

final class the_starting_pointTests: XCTestCase {

    func testStatement() {
        // given
        var invoices: [Invoice]? = nil
        var playsInfo: [String: Play]? = nil
        do {
            let currentDirectoryPath = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
            let sourcesDir = currentDirectoryPath.appendingPathComponent("Sources")
            let theStartingPointDir = sourcesDir.appendingPathComponent("the-starting-point")
            let fileURL = theStartingPointDir.appendingPathComponent("plays.json")
            let playsData = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            invoices = try decoder.decode([Invoice].self, from: try Data(contentsOf: theStartingPointDir.appendingPathComponent("invoices.json")))
            playsInfo = try decoder.decode([String: Play].self, from: playsData)
        } catch let error {
            print("Error: ", error)
        }

        // when
        var result: String? = nil
        if let invoice = invoices?.first, let plays = playsInfo {
            result = the_starting_point.statement(invoice: invoice, plays: plays)
        }

        // then
        let expectedOutput = "Statement for BigCo\n  Hamlet: 650 (55 seats)\n  As You Like It: 580 (35 seats)\n  Othello: 500 (40 seats)\nAmount owed is 1730\nYou earned 47 credits"
        XCTAssertEqual(result, expectedOutput)
    }

    static var allTests = [
        ("testStatement", testStatement),
    ]
}
