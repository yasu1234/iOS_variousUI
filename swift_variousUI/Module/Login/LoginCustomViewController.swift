import RxSwift
import UIKit

class LoginCustomViewController: UIViewController {
    @IBOutlet private weak var loginCustomView: LoginCustomView!
    @IBOutlet private weak var dateSelectTextField: UITextField!
    
    private let datePicker = UIDatePicker()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - UI

extension LoginCustomViewController {
    private func setupUI() {
        setupLoginCustomView()
        setupDatePicker()
    }
    
    private func setupLoginCustomView() {
        let view = loginCustomView.loadNib()
        view.setupTextField()
        view.delegate = self
        view.setupButton()
        view.toggleSecurityTextField()
    }
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .dateAndTime
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        datePicker.preferredDatePickerStyle = .wheels
        
        datePicker.rx.controlEvent(.editingDidBegin)
            .subscribe { _ in
                self.datePicker.resignFirstResponder()
            }
            .disposed(by: disposeBag)
        
        dateSelectTextField.inputView = datePicker
        dateSelectTextField.inputAssistantItem.trailingBarButtonGroups.removeAll()
        dateSelectTextField.inputAssistantItem.leadingBarButtonGroups.removeAll()
        dateSelectTextField.tintColor = UIColor.clear
        
        setupKeyboardAccessory(dateSelectTextField)
    }
    
    private func setupKeyboardAccessory(_ textField: UITextField) {
        let keyboardAccessory = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.size.width,
                height: 36
            )
        )
        
        keyboardAccessory.backgroundColor = UIColor.white
        textField.inputAccessoryView = keyboardAccessory
        
        let completeButton = UIButton(
            frame: CGRect(
                x: keyboardAccessory.bounds.size.width - 48,
                y: 0,
                width: 48,
                height: 36
            )
        )
        completeButton.setTitle("完了", for: .normal)
        completeButton.setTitleColor(UIColor.blue, for: .normal)
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        keyboardAccessory.addSubview(completeButton)
    }
}

// MARK: - Transition

extension LoginCustomViewController {
    private func presentMainView() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else {
                  return
              }
        delegate.showMainContent()
    }
}

// MARK: - Interaction

extension LoginCustomViewController {
    @objc private func completeButtonTapped() {
        dateSelectTextField.resignFirstResponder()
    }
}

// MARK: - LoginCustomViewDelegate

extension LoginCustomViewController: LoginCustomViewDelegate {
    func loginButtonPushed() {
        presentMainView()
    }
}

extension LoginCustomViewController: StoryboardInstance {
    static func newInstance() -> LoginCustomViewController {
        let controller = UIStoryboard(
            name:LoginCustomViewController.storyboardName(),
            bundle: nil
        ).instantiateViewController(withIdentifier: LoginCustomViewController.identifer())
        as! LoginCustomViewController
        
        return controller
    }
    
    static func storyboardName() -> String {
        return "Login"
    }
    
    static func identifer() -> String {
        return String(describing: LoginCustomViewController.self)
    }
}
