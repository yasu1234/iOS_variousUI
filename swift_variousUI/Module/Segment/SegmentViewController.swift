import RxCocoa
import RxSwift
import UIKit

class SegmentViewController: UIViewController {
    @IBOutlet private weak var segment: UISegmentedControl!
    @IBOutlet private weak var customSegmentControl: CustomSegmentControl!
    @IBOutlet private weak var switchView: UIView!
    
    private lazy var firstIndexViewController: SwitchViewController = {
        let viewController = SwitchViewController.newInstance(currentIndex: 0)
        add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var secondIndexViewController: SwitchViewController = {
        let viewController = SwitchViewController.newInstance(currentIndex: 1)
        add(asChildViewController: viewController)
        return viewController
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - UI

extension SegmentViewController {
    private func setupUI() {
        setupSegmentControl()
    }
    
    private func setupSegmentControl() {
        // if you don't use rx, use @IBAction to detect selected segment index(select value changed in sent event)
        segment.rx.selectedSegmentIndex
            .bind { index in
                self.updateView()
        }.disposed(by: disposeBag)
    }
    
    private func updateView() {
        if segment.selectedSegmentIndex == 0 {
            remove(asChildViewController: secondIndexViewController)
            add(asChildViewController: firstIndexViewController)
        } else {
            remove(asChildViewController: firstIndexViewController)
            add(asChildViewController: secondIndexViewController)
        }
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        // It's point to add children ViewController's View as Subview
        switchView.addSubview(viewController.view)
        viewController.view.frame = switchView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}

extension SegmentViewController: StoryboardInstance {
    static func newInstance() -> SegmentViewController {
        let controller = UIStoryboard(
            name: SegmentViewController.storyboardName(),
            bundle: nil
        ).instantiateViewController(withIdentifier: SegmentViewController.identifer()) as! SegmentViewController
        
        return controller
    }
    
    static func storyboardName() -> String {
        return "Segment"
    }
    
    static func identifer() -> String {
        return String(describing: SegmentViewController.self)
    }
}
