import UIKit

class CompositionalLayoutsCollectionViewInteractor: NSObject {
    weak var collectionView: CompositionalLayoutsCollectionView?
    
    private typealias SectionType = CompositionalLayoutsCollectionView.SectionType
    
    func configure(_ collectionView: CompositionalLayoutsCollectionView) {
        self.collectionView = collectionView
        
        collectionView.dataSource = self
//        collectionView.delegate = self
    }
}

extension CompositionalLayoutsCollectionViewInteractor: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch SectionType.allCases[section] {
        case .main:
            return 1
        case .sub:
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch SectionType.allCases[indexPath.section] {
        case .main:
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: String(describing: CompositionalLayoutsCollectionCell.self),
                                     for: indexPath) as? CompositionalLayoutsCollectionCell
            if let cell = cell {
                cell.number = indexPath.row
                return cell
            }
        case .sub:
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: String(describing: CompositionalLayoutsCollectionCell.self),
                                     for: indexPath) as? CompositionalLayoutsCollectionCell
            if let cell = cell {
                cell.number = indexPath.row
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
}
