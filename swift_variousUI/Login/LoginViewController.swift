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
    
    private func presentMainView() {
        let controller = CollectionViewController.newInstance()
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
            presentMainView()
        }
    }
}

