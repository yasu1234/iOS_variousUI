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
    static func newInstance() -> SegmentViewController {
        let controller = UIStoryboard(
            name: SegmentViewController.storyboardName(),
            bundle: nil).instantiateViewController(withIdentifier: SegmentViewController.identifer()) as! SegmentViewController
        
        return controller
    }
    
    static func storyboardName() -> String {
        return "Segment"
    }
    
    static func identifer() -> String {
        return String(describing: SegmentViewController.self)
    }
}
