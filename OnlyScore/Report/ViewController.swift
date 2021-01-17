import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var creditScore: UILabel!
    @IBOutlet weak var donut: DonutView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var errorView: UIView!
    
    var report = ReportViewModel() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.view.setNeedsLayout()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadScore()
    }
    
    override func viewWillLayoutSubviews() {
        switch report.state {
        case .show(let report):
            donut.isHidden = false
            spinner.stopAnimating()
            creditScore.text = "\(report.score)"
            errorView.isHidden = true
        case .loading:
            donut.isHidden = true
            spinner.startAnimating()
            errorView.isHidden = true
        case .error(let err):
            donut.isHidden = true
            spinner.stopAnimating()
            errorView.isHidden = false
            error.text = err.localizedDescription
            break
        }
        super.viewWillLayoutSubviews()
    }
    
    @IBAction func retry(_ sender: Any) {
        loadScore()
    }
    
    func loadScore() {
        report.load { [weak self] response in
            self?.report = response
        }
    }
}

