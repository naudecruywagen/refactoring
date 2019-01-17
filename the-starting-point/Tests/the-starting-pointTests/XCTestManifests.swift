import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(the_starting_pointTests.allTests),
    ]
}
#endif