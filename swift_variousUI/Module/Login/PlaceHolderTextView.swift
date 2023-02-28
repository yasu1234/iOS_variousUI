import UIKit

class PlaceHolderTextView: UITextView {
    @IBInspectable var placeHolder: String = "" {
        willSet {
            placeHolderLabel.text = newValue
            placeHolderLabel.sizeToFit()
        }
    }
    
    lazy var placeHolderLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 10.0,
                                          y: 14.5,
                                          width: 300.0,
                                          height: 19.0))
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = self.font
        label.backgroundColor = .clear
        addSubview(label)
        
        return label
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textChanged),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)
    }
    
    private func changeVisiblePlaceHolder() {
        placeHolderLabel.alpha = (self.placeHolder.isEmpty || !self.text.isEmpty) ? 0.0 : 1.0
    }
    
    @objc private func textChanged() {
        changeVisiblePlaceHolder()
    }
}
