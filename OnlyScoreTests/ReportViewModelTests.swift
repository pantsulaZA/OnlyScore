import XCTest
@testable import OnlyScore

class ReportViewModelTests: XCTestCase {
    
    func testCreateWithData() {
        let report = CreditReport(creditReportInfo: CreditReportInfo(score: 777))
        let mockClient = TestableNetworkClient(response: .success(report))
        let exp = expectation(description: "Network client getting reponse")
        let sut = ReportViewModel(client: mockClient)

        switch sut.state {
        case .loading:
            
            sut.load { result in
                switch result.state {
                case .show(let report):
                    XCTAssertEqual(report.score, 777)
                    exp.fulfill()
                default:
                    XCTFail()
                }
            }
        default:
            XCTFail()
        }
        
        wait(for: [exp], timeout: 0.1)
    }
}

class TestableNetworkClient: NetworkClient {
    var testResponse: Result<CreditReport, Error>
    
    init(response: Result<CreditReport, Error>) {
        testResponse = response
        super.init()
    }
    override func getReport(completion: @escaping (Result<CreditReport, Error>) -> Void) {
        completion(testResponse)
    }
}
