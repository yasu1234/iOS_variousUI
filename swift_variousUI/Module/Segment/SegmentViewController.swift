import UIKit

class SegmentViewController: UIViewController {
    @IBOutlet private weak var segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension SegmentViewController {
    private func setupUI() {
    }
}

extension SegmentViewController: StoryboardInstance {
    static func newInstance() -> LoginCustomViewController {
        let controller = UIStoryboard(
            name:SegmentViewController.storyboardName(),
            bundle: nil).instantiateViewController(withIdentifier: LoginCustomViewController.identifer()) as! LoginCustomViewController
        
        return controller
    }
    
    static func storyboardName() -> String {
        return "Segment"
    }
    
    static func identifer() -> String {
        return String(describing: LoginCustomViewController.self)
    }
}
