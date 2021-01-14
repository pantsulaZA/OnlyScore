import Foundation

struct ScoreData: Decodable {
    var score: Int {
        creditReportInfo.score
    }
    let creditReportInfo: CreditReportInfo
}

struct CreditReportInfo: Decodable {
    let score: Int
}
