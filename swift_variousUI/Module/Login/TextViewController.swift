import UIKit

class TextViewController: UIViewController {
    @IBOutlet private weak var placeHolderTextView: PlaceHolderTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UI

extension TextViewController {
    private func setupUI() {
    }
}

extension TextViewController: StoryboardInstance {
    static func newInstance() -> TextViewController {
        let controller = UIStoryboard(
            name:TextViewController.storyboardName(),
            bundle: nil
        ).instantiateViewController(withIdentifier: TextViewController.identifer()) as! TextViewController
        
        return controller
    }
    
    static func storyboardName() -> String {
        return "Login"
    }
    
    static func identifer() -> String {
        return String(describing: TextViewController.self)
    }
}
