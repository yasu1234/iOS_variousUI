import UIKit

class TableCellTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    
    var user: String? {
        didSet {
            layoutContent()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layoutContent()
    }
}

extension TableCellTableViewCell {
    private func layoutContent() {
        titleLabel.text = user ?? ""
    }
}
