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
        setAttributeString()
    }
    
    private func setAttributeString() {
        let attributeString = NSMutableAttributedString(string: "TEST TEST TEST")
        
        let image = UIImage(named: "icon_kuma")!
        let font: UIFont = .systemFont(ofSize: 17)
        let size = CGSize(width: 30, height: 30)
        
        let attachment = NSTextAttachment()
        attachment.image = image
        
        let y = (font.capHeight - size.height).rounded() / 2
        attachment.bounds.origin = CGPoint(x: 0, y: y)
        attachment.bounds.size = size
        
        let imageAttribute = NSAttributedString(attachment: attachment)
        // add image at last
        attributeString.insert(imageAttribute, at: attributeString.length)
        
        let underlineAttributes: [NSAttributedString.Key: Any] = [
            .underlineColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        attributeString.addAttributes(underlineAttributes, range: NSRange(location: 0, length: 2))
        
        attributeStringLabel.attributedText = attributeString
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
