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
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
        
    func loadNib() -> Self {
        let view = UINib(nibName: "LoginCustomView", bundle: nil).instantiate(withOwner: self, options: nil).first as! Self
        
        addSubview(view)
        
        return view
    }
}

extension LoginCustomView {
    @IBAction private func loginButtonPushed(_ sender: Any) {
        delegate?.loginButtonPushed()
    }
}
