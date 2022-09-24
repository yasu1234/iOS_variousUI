import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        let identifier = String(describing: cellType)
        register(UINib(nibName: identifier, bundle: nil),
                 forCellWithReuseIdentifier: identifier)
    }
}
