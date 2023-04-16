import UIKit

class SliderViewController: UIViewController {
    @IBOutlet private weak var divisionsSlider: UISlider!
    @IBOutlet private weak var customSlider: CustomSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - UI

extension SliderViewController {
    private func setupUI() {
        divisionsSlider.addTarget(self, action: #selector(sliderValueChanged(slider:event:)), for: .valueChanged)
        
        setDivisionSlider(0)
        setCustomSlider()
    }
    
    private func setDivisionSlider(_ value: Int) {
        divisionsSlider.value = Float(value)
        
        if value == 2 {
            let image = UIImage(named: "icon_kuma")!
            let resizedSize = CGSize(width: 20.0, height: 20.0)
            UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0)
            image.draw(in: CGRect(origin: .zero, size: resizedSize))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            divisionsSlider.setThumbImage(resizedImage, for: .normal)
        }
    }
    
    private func setCustomSlider() {
        customSlider.updateMaxValue(5)
    }
}

// MARK: - Interaction

extension SliderViewController {
    // detect action (e.g drag/ move)
    @objc private func sliderValueChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began, .moved:
                break
            case .ended:
                let index = round(divisionsSlider.value)
                divisionsSlider.value = index
                setDivisionSlider(Int(index))
            default:
                break
            }
        }
    }
    
    @IBAction func showProgressViewButtonPushed(_ sender: Any) {
        let controller = ProgressViewController.newInstance()
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension SliderViewController: StoryboardInstance {
    static func newInstance() -> SliderViewController {
        let controller = UIStoryboard(
            name: SliderViewController.storyboardName(),
            bundle: nil
        ).instantiateViewController(withIdentifier: SliderViewController.identifer()) as! SliderViewController
        
        return controller
    }
    
    static func storyboardName() -> String {
        return "Bar"
    }
    
    static func identifer() -> String {
        return String(describing: SliderViewController.self)
    }
}
