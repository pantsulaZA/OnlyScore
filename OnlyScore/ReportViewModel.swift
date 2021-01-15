import Foundation

struct ReportViewModel {
    enum ScoreViewState {
        case loading
        case show(CreditReport)
        case error(Error)
    }
    
    var state: ScoreViewState
    private var client: NetworkClient
    
    init(client: NetworkClient? = nil) {
        self.state = .loading
        self.client = client ?? NetworkClient()
    }
    
    func load(completion: @escaping (ReportViewModel) -> Void) {
        var newData = self
        client.getReport { result in
            switch result {
            case .success(let report):
                newData.state = .show(report)
            case .failure(let err):
                newData.state = .error(err)
            }
            completion(newData)
        }
    }
}
