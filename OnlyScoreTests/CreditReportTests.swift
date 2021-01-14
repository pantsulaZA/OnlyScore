import XCTest
@testable import OnlyScore

class CreditReportTests: XCTestCase {

    func testCreateFromJSON() {
        if let data = loadJson(filename: "scoreData") {
        
        let sut = try? JSONDecoder().decode(CreditReport.self, from: data)
        
            XCTAssertEqual(sut?.score, 514)
        } else {
            XCTFail("No data for file")
        }
    }
}

func loadJson(filename fileName: String) -> Data? {
    if let url = Bundle(for: CreditReportTests.self).url(forResource: fileName, withExtension: "json") {
        do {
            return try Data(contentsOf: url)
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}
