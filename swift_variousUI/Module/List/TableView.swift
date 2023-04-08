import UIKit

class TableView: UITableView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerNib()
        
        tableFooterView = UIView()
    }
    
    private func registerNib() {
        registerCell(cellType: TableCellTableViewCell.self)
    }
}
