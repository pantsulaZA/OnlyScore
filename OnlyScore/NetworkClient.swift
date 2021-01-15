import Foundation

class NetworkClient {
    let session: URLSession
    
    init(session: URLSession? = nil) {
        self.session = session ?? URLSession.shared
    }
    
    func getReport(completion: @escaping (Result<CreditReport, Error>) -> Void) {
        session.dataTask(with: Endpoint.report.url) { (data, response, error) in
            if (response as? HTTPURLResponse)?.statusCode == 200,
            let data = data,
               let report = try? JSONDecoder().decode(CreditReport.self, from: data) {
                completion(.success(report))
            } else {
                completion(.failure(error ?? NSError(domain: "OnlyScore.NetworkClient",
                                                     code: 1,
                                                     userInfo: ["Message" : "Unknown network error"])))
            }
        }.resume()
    }
}
