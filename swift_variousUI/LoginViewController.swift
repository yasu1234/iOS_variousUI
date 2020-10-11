//
//  LoginViewController.swift
//  swift_variousUI
//
//  Created by kuma on 2020/10/11.
//  Copyright © 2020 kuma. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginFormDelegate {
    
    @IBOutlet private weak var loginForm: LoginForm!
    @IBOutlet weak var realLoginView: UIView!
    @IBOutlet weak var fakeLoginView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginForm.delegate = self

    }
    
    func realLogin(isFirstTap: Bool) {
        if isFirstTap {
            changeRealLoginView()
        } else {
            presentMainView()
        }
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
    }
}

