import UIKit

class CompositionalLayoutsCollectionCell: UICollectionViewCell {
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var number: Int? {
        didSet {
            layoutContent()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layoutContent()
    }
}

extension CompositionalLayoutsCollectionCell {
    private func layoutContent() {
        if let number = number {
            numberLabel.text = "\(number)"
            titleLabel.text = "\(number)" + "title"
        }
    }
}
