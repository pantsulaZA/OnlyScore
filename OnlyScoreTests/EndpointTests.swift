import XCTest
@testable import OnlyScore

class EndpointTests: XCTestCase {

    func testHasCorrectUrl() {
        let sut = Endpoint.report
        XCTAssertEqual(sut.url.absoluteString, "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values")
    }

}
