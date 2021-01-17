import Foundation
import UIKit

@IBDesignable
class DonutView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = frame.width/2
    }
}
