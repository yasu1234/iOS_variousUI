import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(cellType: T.Type) {
        let identifier = String(describing: cellType)
        register(
            UINib(nibName: identifier, bundle: nil),
            forCellReuseIdentifier: identifier
        )
    }
    
    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(typeOf cellType: T.Type) {
        let identifier = String(describing: cellType)
        
        register(
            UINib(nibName: identifier, bundle: nil),
            forHeaderFooterViewReuseIdentifier: identifier
        )
    }
}
