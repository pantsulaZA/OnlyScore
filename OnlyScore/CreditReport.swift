import Foundation

struct CreditReport: Decodable {
    var score: Int {
        creditReportInfo.score
    }
    private let creditReportInfo: CreditReportInfo
}

struct CreditReportInfo: Decodable {
    let score: Int
}
