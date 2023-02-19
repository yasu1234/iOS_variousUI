import UIKit

class LoginCustomViewController: UIViewController {
    @IBOutlet private weak var loginCustomView: LoginCustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension LoginCustomViewController {
    private func setupUI() {
        setupLoginCustomView()
    }
    
    private func setupLoginCustomView() {
        let view = loginCustomView.loadNib()
        view.setupTextField()
        view.delegate = self
    }
}

extension LoginCustomViewController {
    private func presentMainView() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else {
                  return
              }
        delegate.showMainContent()
    }
}

extension LoginCustomViewController: LoginCustomViewDelegate {
    func loginButtonPushed() {
        presentMainView()
    }
}

extension LoginCustomViewController: StoryboardInstance {
    static func newInstance() -> LoginCustomViewController {
        let controller = UIStoryboard(name:LoginCustomViewController.storyboardName(), bundle: nil).instantiateViewController(withIdentifier: LoginCustomViewController.identifer()) as! LoginCustomViewController
        
        return controller
    }
    
    static func storyboardName() -> String {
        return "Login"
    }
    
    static func identifer() -> String {
        return String(describing: LoginCustomViewController.self)
    }
}
