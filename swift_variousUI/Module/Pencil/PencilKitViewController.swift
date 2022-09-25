import PencilKit
import UIKit

@available(iOS 14.0, *)
class PencilKitViewController: UIViewController {
    @IBOutlet private weak var pencilKit: PKCanvasView!
    
    private let pkToolPicker = PKToolPicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCanvasView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let pencilKit = pencilKit {
            pkToolPicker.setVisible(true, forFirstResponder: pencilKit)
            pkToolPicker.addObserver(pencilKit)
        }
    }
}

@available(iOS 14.0, *)
extension PencilKitViewController {
    private func setupCanvasView() {
        pencilKit.tool = PKInkingTool(.pen, color: .black, width: 30)
        pencilKit.drawingPolicy = .anyInput
        
        pencilKit.isOpaque = true
        pencilKit.backgroundColor = .clear
        pencilKit.becomeFirstResponder()
    }
}

@available(iOS 14.0, *)
extension PencilKitViewController: StoryboardInstance {
    static func newInstance() -> PencilKitViewController {
        let controller = UIStoryboard(name:PencilKitViewController.storyboardName(),
                                      bundle: nil).instantiateViewController(withIdentifier: PencilKitViewController.identifer()) as! PencilKitViewController
        
        return controller
    }
    
    static func storyboardName() -> String {
        return "Pencil"
    }
    
    static func identifer() -> String {
        return String(describing: PencilKitViewController.self)
    }
}
