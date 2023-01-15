import UIKit

class AttributeStringViewController: UIViewController {
    @IBOutlet private weak var attributeStringLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - UI

extension AttributeStringViewController {
    private func setupUI() {
    }
}

extension AttributeStringViewController: StoryboardInstance {
    static func newInstance() -> AttributeStringViewController {
        let controller = UIStoryboard(
            name:AttributeStringViewController.storyboardName(),
            bundle: nil
        ).instantiateViewController(withIdentifier: AttributeStringViewController.identifer())
        as! AttributeStringViewController
        
        return controller
    }
    
    static func storyboardName() -> String {
        return "AttributeString"
    }
    
    static func identifer() -> String {
        return String(describing: AttributeStringViewController.self)
    }
}
