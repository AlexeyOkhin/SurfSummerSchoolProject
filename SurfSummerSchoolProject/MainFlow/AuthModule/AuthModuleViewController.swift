//
//  AuthModuleViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 15.08.2022.
//

import UIKit

class AuthorizationViewController: UIViewController {
    /// Root view
    private var authView: LoginView { self.view as! LoginView  }

    // MARK: - Private Properties
    
    private var loginTF: LoginTextfield { return authView.loginTF }
    private var passwordTF: PasswordTextfield { authView.passwordTF }
    private var loginButton: UIButton { authView.loginButton }
    private var activityIndicator: UIActivityIndicatorView { authView.activityIndicator }
    
    private var isProcessing: Bool = false {
        didSet {
            if isProcessing {
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
            } else {
                activityIndicator.isHidden = true
                activityIndicator.stopAnimating()
            }
        }
    }
    
    // MARK: - Life Cycle ViewController
    
    override func loadView() {
        super.loadView()
        self.view = LoginView(frame: self.view.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Авторизация"
        self.navigationController?.navigationBar.tintColor = .black
        self.view.backgroundColor = .white
        commonInit()
        setupNotificationKeyboard()
    }
    
    // MARK: - Private functions
    private func commonInit () {
        loginTF.delegate = self
        passwordTF.delegate = self
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
    }
    
    private func setupNotificationKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect {
            self.authView.layoutIfNeeded()
            UIView.animate(withDuration: 0.4 ) {
                self.authView.frameCenterYConstraint?.constant = -keyboardFrame.height/2
                self.authView.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardHide(notification: NSNotification) {
        self.authView.layoutIfNeeded()
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut ) {
            self.authView.frameCenterYConstraint?.constant = 0
            self.authView.layoutIfNeeded()
        }
    }
    
    @objc private func loginAction() {
        loginTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        
        if checkFields() {
            isProcessing = true
            guard let textLoginTF = loginTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
            guard let textPasswordTF = passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
            
            // logic
        }
    }
    
    private func checkFields () -> Bool {
        guard let textLoginTF = loginTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return false }
        guard let textPasswordTF = passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return false }
        
        //loginTF.isInvalid = testLoginTF.isEmpty ? true : false
        
        if textLoginTF.isEmpty && textPasswordTF.isEmpty {
            loginTF.isInvalid = true
            passwordTF.isInvalid = true
            /// Вывод сообщения
            return false
        }
        
        if textLoginTF.isEmpty {
            loginTF.isInvalid = true
            /// Вывод сообщения
            return false
        } else {
            loginTF.isInvalid = false
        }

        if textPasswordTF.isEmpty {
            passwordTF.isInvalid = true
            /// Вывод сообщения
            return false
        } else {
            passwordTF.isInvalid = false
        }
        
        if !textLoginTF.isEmpty && !textPasswordTF.isEmpty {
            return true
        }
        
        return false
    }
    
}

// MARK: - UITextViewDelegate
extension AuthorizationViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTF {
            passwordTF.becomeFirstResponder()
        }
        if textField == passwordTF {
            loginAction()
        }
        return true
    }
    
}


