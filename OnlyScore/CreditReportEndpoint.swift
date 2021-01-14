import Foundation

enum Endpoint {
    case report
    
    var url: URL {
        switch self {
        case .report:
            return URL(string:  "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values")!
        }
    }
}
