import UIKit

class CollectionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let testCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TestCollectionViewCell
        testCell.numberName = String(indexPath.row)
                
        return testCell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    // outer margin area of collectionview
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10 , left: 20 , bottom: 10 , right: 20)
    }
    
    // vertical margin between cell and cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
        
    // horizontal margin between cell and cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize: CGFloat = (self.view.bounds.width - 50) / 2
        
        return CGSize(width: cellSize, height: 150)
    }
}

extension CollectionViewController: StoryboardInstance {
    static func newInstance() -> CollectionViewController {
        let controller = UIStoryboard(name:CollectionViewController.storyboardName(), bundle: nil).instantiateViewController(withIdentifier: CollectionViewController.identifer()) as! CollectionViewController
        
        return controller
    }
    
    static func storyboardName() -> String {
        return "Collection"
    }
    
    static func identifer() -> String {
        return String(describing: CollectionViewController.self)
    }
}
