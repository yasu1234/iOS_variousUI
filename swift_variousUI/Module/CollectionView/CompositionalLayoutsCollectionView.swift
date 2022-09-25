import Foundation
import UIKit

class CompositionalLayoutsCollectionView: UICollectionView {
    enum SectionType: CaseIterable {
        case applianceHorizontal
        case article
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerAllNibs()
        setupLayouts()
    }
    
    private func registerAllNibs() {
        register(cellType: CompositionalLayoutsCollectionCell.self)
    }
    
    private func setupLayouts() {
        collectionViewLayout = UICollectionViewCompositionalLayout { sectionIndex,_ -> NSCollectionLayoutSection? in
            let sectionLayoutKind = SectionType.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .applianceHorizontal:
                return self.generateApplianceHorizontalLayout()
            case .article:
                return self.generateArticleLayout()
            }
        }
    }
}

extension CompositionalLayoutsCollectionView {
    private func generateApplianceHorizontalLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(2/3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(2/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .paging
        
        return section
    }
    
    private func generateArticleLayout() -> NSCollectionLayoutSection {
        let fullArticleItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                         heightDimension: .fractionalHeight(1/4))
        let fullArticleItem = NSCollectionLayoutItem(layoutSize: fullArticleItemSize)
        
        let pairArticleItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                                         heightDimension: .fractionalHeight(1))
        let pairArticleItem = NSCollectionLayoutItem(layoutSize: pairArticleItemSize)
        let pairGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalHeight(1/4))
        let pairGroup = NSCollectionLayoutGroup.horizontal(layoutSize: pairGroupSize, subitem: pairArticleItem, count: 2)
        
        let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                     heightDimension: .fractionalHeight(1))
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize, subitems: [pairGroup, fullArticleItem])
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        
        return section
    }
}
