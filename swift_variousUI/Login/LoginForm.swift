//
//  LoginForm.swift
//  swift_variousUI
//
//  Created by kuma on 2020/10/11.
//  Copyright © 2020 kuma. All rights reserved.
//

import UIKit

protocol LoginFormDelegate: class {
    func realLogin(isFirstTap: Bool)
}

class LoginForm: UIView {

    @IBOutlet private weak var loginButton: UIButton!
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

    @IBAction func tapLoginButton(_ sender: Any) {
        if (loginTapCount == 0) {
            loginButton.titleLabel?.text = "真ログイン"
            realLogin(isFirstTap: false)
            loginTapCount += 1
        } else {
            realLogin(isFirstTap: true)
        }
    }
}

// MARK: - delegate
extension LoginForm {
    func realLogin(isFirstTap: Bool) {
        delegate?.realLogin(isFirstTap: isFirstTap)
    }
}
