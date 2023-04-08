import UIKit

class CalenderCollectionView: UICollectionView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerAllNib()
        setupLayouts()
    }
    
    private func registerAllNib() {
        register(cellType: CalendarCell.self)
    }
    
    private func setupLayouts() {
        generateLayout()
    }
}

extension CalenderCollectionView {
    private func generateLayout() {
        collectionViewLayout = UICollectionViewCompositionalLayout { sectionIndex,_ -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .absolute(65))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize,
                                                         subitem: layoutItem,
                                                         count: 7)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(65))
            
            let groups = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                          subitems: [group])
            let section = NSCollectionLayoutSection(group: groups)
            
            return section
        }
    }
}
