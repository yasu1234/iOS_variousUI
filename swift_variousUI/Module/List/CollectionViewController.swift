import UIKit

class CollectionViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
    }
}

// MARK: - Transition

extension CollectionViewController {
    private func pushPencilKitViewController() {
        if #available(iOS 14.0, *) {
            let controller = PencilKitViewController.newInstance()
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    private func pushCompositionalLayoutsViewController() {
        let controller = CompositionalLayoutsViewController.newInstance()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func pushCalenderViewController() {
        let controller = CalenderViewController.newInstance()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func pushAttributeStringViewController() {
        let controller = AttributeStringViewController.newInstance()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func pushCameraViewController() {
        let controller = CameraViewController.newInstance()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func pushTextViewController() {
        let controller = TextViewController.newInstance()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func pushSliderViewController() {
        let controller = SliderViewController.newInstance()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func pushTableViewController() {
        let controller = TableViewController.newInstance()
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

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

// MARK: - UICollectionViewDelegate

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            pushPencilKitViewController()
        } else if indexPath.row == 1 {
            pushCompositionalLayoutsViewController()
        } else if indexPath.row == 2 {
            pushCalenderViewController()
        } else if indexPath.row == 3 {
            pushAttributeStringViewController()
        } else if indexPath.row == 4 {
            pushCameraViewController()
        } else if indexPath.row == 5 {
            pushTextViewController()
        } else if indexPath.row == 6 {
            pushSliderViewController()
        } else if indexPath.row == 7 {
            pushTableViewController()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

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
        return "List"
    }
    
    static func identifer() -> String {
        return String(describing: CollectionViewController.self)
    }
}
