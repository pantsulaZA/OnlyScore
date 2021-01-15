import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var creditScore: UILabel!
    var report = ReportViewModel() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.view.setNeedsLayout()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        report.load { [weak self] response in
            self?.report = response
        }
    }
    
    override func viewDidLayoutSubviews() {
        switch report.state {
        case .show(let report):
            creditScore.text = "\(report.score)"
        default:
            break
        }
        super.viewDidLayoutSubviews()
    }
}

