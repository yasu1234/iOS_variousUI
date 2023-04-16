import UIKit

class ProgressViewController: UIViewController {
    @IBOutlet private weak var defaultProgressView: UIProgressView!
    @IBOutlet private weak var barProgressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - UI

extension ProgressViewController {
    private func setupUI() {
        setupProgressView()
    }
    
    // Progress Tint is color of progress.
    // Trak Tint is color of unprogress
    // Progress Image is image of progress
    // Track Image is image of unprogress
    private func setupProgressView() {
        // change width
        defaultProgressView.transform = CGAffineTransformMakeScale(1.0, 10.0)
        
        // rotation vertically
        barProgressView.transform = CGAffineTransformMakeRotation(Double.pi / 2)
    }
}


extension ProgressViewController: StoryboardInstance {
    static func newInstance() -> ProgressViewController {
        let controller = UIStoryboard(
            name: ProgressViewController.storyboardName(),
            bundle: nil
        ).instantiateViewController(
            withIdentifier: ProgressViewController.identifer()
        ) as! ProgressViewController
        
        return controller
    }
    
    static func storyboardName() -> String {
        return "Bar"
    }
    
    static func identifer() -> String {
        return String(describing: ProgressViewController.self)
    }
}
