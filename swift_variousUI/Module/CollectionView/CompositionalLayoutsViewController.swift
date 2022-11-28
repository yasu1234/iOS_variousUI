import UIKit

class CompositionalLayoutsViewController: UIViewController {
    @IBOutlet private weak var collectionView: CompositionalLayoutsCollectionView!
    
    private let collectionViewInteractor = CompositionalLayoutsCollectionViewInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension CompositionalLayoutsViewController {
    private func setupUI() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionViewInteractor.configure(collectionView)
    }
}

extension CompositionalLayoutsViewController: StoryboardInstance {
    static func newInstance() -> CompositionalLayoutsViewController {
        let controller = UIStoryboard(name:CompositionalLayoutsViewController.storyboardName(), bundle: nil).instantiateViewController(withIdentifier: CompositionalLayoutsViewController.identifer()) as! CompositionalLayoutsViewController
        
        return controller
    }
    
    static func storyboardName() -> String {
        return "Collection"
    }
    
    static func identifer() -> String {
        return String(describing: CompositionalLayoutsViewController.self)
    }
}
