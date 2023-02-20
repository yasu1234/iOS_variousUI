import RxSwift
import UIKit

protocol LoginCustomViewDelegate: AnyObject {
    func loginButtonPushed()
}

class LoginCustomView: UIView {
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var loginIdTextField: UITextField!
    @IBOutlet private weak var passwordSecureTextField: PasswordSecureTextField!
    @IBOutlet private weak var passwordSecurityButton: UIButton!
    
    weak var delegate: LoginCustomViewDelegate?
    
    private let disposeBag = DisposeBag()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
    
    func setupTextField() {
        // hide cursor when focus. if you want to show cursor, this line should comment out
        loginIdTextField.tintColor = UIColor.clear
    }
    
    func setupButton() {
        passwordSecurityButton.rx.tap
            .subscribe { _ in
                self.toggleSecurityTextField()
            }.disposed(by: disposeBag)
    }
    
    func toggleSecurityTextField() {
        if passwordSecureTextField.isSecureTextEntry {
            passwordSecureTextField.isSecureTextEntry = false
            passwordSecurityButton.setTitle("非表示", for: .normal)
        } else {
            passwordSecureTextField.isSecureTextEntry = true
            passwordSecurityButton.setTitle("表示", for: .normal)
        }
    }
}

extension LoginCustomView {
    @IBAction private func loginButtonPushed(_ sender: Any) {
        delegate?.loginButtonPushed()
    }
}
