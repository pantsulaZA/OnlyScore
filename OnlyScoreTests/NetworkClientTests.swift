import XCTest
@testable import OnlyScore

class NetworkClientTests: XCTestCase {

    var session = TestableSession()
    var sut: NetworkClient!
    
    override func setUp() {
        session = TestableSession()
        sut = NetworkClient(session: session)
    }
    
    func testGetReport() {
        let response = loadJson(filename: "scoreData")
        session.testData = response
        let exp = expectation(description: "Get report network call")
        
        sut.getReport { response in
            XCTAssertNotNil(response)
            switch response {
            case .success(let report):
                XCTAssertEqual(report.score, 514)
                exp.fulfill()
            case .failure(let err):
                XCTFail(err.localizedDescription)
            }
        }
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func testGetReport_NoData() {
        session.testData = nil
        let exp = expectation(description: "Get report network call")
        
        sut.getReport { response in
            XCTAssertNotNil(response)
            switch response {
            case .success(let report):
                XCTFail("Should fail")
              case .failure(let err):
                exp.fulfill()
          }
        }
        
        wait(for: [exp], timeout: 0.1)
    }
}

class TestableSession: URLSession {
    var testData: Data?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = TestableTask()
        task.testData = testData
        task.mockCompletion = completionHandler
        return task
    }
}

class TestableTask: URLSessionDataTask {
    var testData: Data?
    var mockCompletion: ((Data?, URLResponse?, Error?) -> Void)?
    
    override func resume() {
        let testReponse = HTTPURLResponse(url: Endpoint.report.url,
                                      statusCode: 200,
                                      httpVersion: nil,
                                      headerFields: nil)
        mockCompletion?(testData, testReponse, nil)
    }
}
