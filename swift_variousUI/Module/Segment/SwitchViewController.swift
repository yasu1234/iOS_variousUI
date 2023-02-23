import UIKit

class SwitchViewController: UIViewController {
    @IBOutlet private weak var currentIndexLabel: UILabel!
    
    private var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - UI

extension SwitchViewController {
    private func setupUI() {
        setCurrentIndex()
    }
    
    private func setCurrentIndex() {
        currentIndexLabel.text = "\(currentIndex)"
    }
}

extension SwitchViewController: StoryboardInstance {
    static func newInstance(currentIndex: Int) -> SwitchViewController {
        let controller = UIStoryboard(
            name: SwitchViewController.storyboardName(),
            bundle: nil
        ).instantiateViewController(withIdentifier: SwitchViewController.identifer()) as! SwitchViewController
        
        controller.currentIndex = currentIndex
        
        return controller
    }
    
    static func storyboardName() -> String {
        return "Segment"
    }
    
    static func identifer() -> String {
        return String(describing: SwitchViewController.self)
    }
}
