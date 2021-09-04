import UIKit

class TestCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var numberLabel: UILabel!
    
    var numberName: String? {
        didSet  {
            layoutContent()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layoutContent()
    }
}

extension TestCollectionViewCell {
    private func layoutContent() {
        numberLabel.text = numberName
    }
}
