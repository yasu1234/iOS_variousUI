import UIKit

class LoginViewController: UIViewController {
    @IBOutlet private weak var loginForm: LoginForm!
    @IBOutlet weak var realLoginView: UIView!
    @IBOutlet weak var fakeLoginView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginForm.delegate = self

    }
}

// MARK: - UI

extension LoginViewController {
    
    private func changeRealLoginView() {
        titleLabel.text = "真ログイン画面だよーーん！！"
        fakeLoginView.isHidden = true
    }
}

// MARK: - Transition

extension LoginViewController {
    private func presentLoginCustomViewController() {
        let controller = LoginCustomViewController.newInstance()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
}


// MARK: - LoginFormDelegate

extension LoginViewController: LoginFormDelegate {
    func realLogin(isFirstTap: Bool) {
        if isFirstTap {
            changeRealLoginView()
        } else {
            presentLoginCustomViewController()
        }
    }
}

extension LoginViewController: StoryboardInstance {
    static func newInstance() -> LoginViewController {
        let controller = UIStoryboard(name:LoginViewController.storyboardName(), bundle: nil).instantiateViewController(withIdentifier: LoginViewController.identifer()) as! LoginViewController
        
        return controller
    }
    
    static func storyboardName() -> String {
        return "Login"
    }
    
    static func identifer() -> String {
        return String(describing: LoginViewController.self)
    }
}

