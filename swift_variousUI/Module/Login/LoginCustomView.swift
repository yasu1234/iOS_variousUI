import UIKit

protocol LoginCustomViewDelegate: AnyObject {
    func loginButtonPushed()
}

class LoginCustomView: UIView {
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var loginIdTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    weak var delegate: LoginCustomViewDelegate?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupTextField()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
        
    func loadNib() -> Self {
        let view = UINib(
            nibName: "LoginCustomView",
            bundle: nil
        ).instantiate(withOwner: self, options: nil).first as! Self
        
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[view]-0-|",
            options: NSLayoutConstraint.FormatOptions(rawValue: 0),
            metrics: nil,
            views: ["view" : view])
        )
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[view]-0-|",
            options: NSLayoutConstraint.FormatOptions(rawValue: 0),
            metrics: nil,
            views: ["view" : view])
        )
        
        return view
    }
    
    private func setupTextField() {
        // hide cursor when focus. if you want to show cursor, this line should comment out
        loginIdTextField.tintColor = UIColor.clear
    }
}

extension LoginCustomView {
    @IBAction private func loginButtonPushed(_ sender: Any) {
        delegate?.loginButtonPushed()
    }
}
