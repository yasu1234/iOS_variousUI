import UIKit

protocol LoginFormDelegate: AnyObject {
    func realLogin(isFirstTap: Bool)
}

class LoginForm: UIView {
    @IBOutlet private weak var loginButton: RippleButton!
    private var loginTapCount = 0
    weak var delegate: LoginFormDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    // if you use storyboard, this initializer is called (init is not called)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
    
    // dispaly in Interface Builder
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadNib()
    }
    
    private func loadNib() {
        
        let view = UINib(nibName: "LoginForm", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = self.bounds
        addSubview(view)
    }

}

extension LoginForm {
    @IBAction func tapLoginButton(_ sender: Any) {
        if (loginTapCount == 0) {
            loginButton.titleLabel?.text = "真ログイン"
            realLogin(isFirstTap: true)
            loginTapCount += 1
        } else {
            realLogin(isFirstTap: false)
        }
    }
}

// MARK: - Delegate

extension LoginForm {
    func realLogin(isFirstTap: Bool) {
        delegate?.realLogin(isFirstTap: isFirstTap)
    }
}
