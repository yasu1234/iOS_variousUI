import UIKit

class CalendarCell: UICollectionViewCell {
    @IBOutlet private weak var dateLabel: UILabel!
    
    var dateText: String? {
        didSet {
            layoutContent()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layoutContent()
    }
}

extension CalendarCell {
    private func layoutContent() {
        dateLabel.text = dateText ?? ""
    }
}
