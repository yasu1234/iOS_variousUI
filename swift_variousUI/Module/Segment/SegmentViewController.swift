import RxCocoa
import RxSwift
import UIKit

class SegmentViewController: UIViewController {
    @IBOutlet private weak var segment: UISegmentedControl!
    @IBOutlet private weak var selectSegmentIndexLabel: UILabel!
    @IBOutlet private weak var customSegmentControl: CustomSegmentControl!
    
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
                self.selectSegmentIndexLabel.text = "\(index)"
        }.disposed(by: disposeBag)
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
