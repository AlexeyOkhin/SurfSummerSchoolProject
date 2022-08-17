//
//  TestAuthViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 17.08.2022.
//

import UIKit
class TestAuthViewController: UIViewController {
    
    enum TextFieldTag: Int {
        case loginFieldTag = 0
        case passwordFieldTag = 1
    }
    
    //MARK: - IBUutlet constraints
    
    @IBOutlet private weak var keyboardUpConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var passwordTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var loginTopConstraint: NSLayoutConstraint!
    
    //MARK: - IBOutlets Views
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var surfBackgrroundImage: UIImageView!
    
    @IBOutlet private weak var loginTF: UITextField!
    @IBOutlet private weak var loginFloatingLabel: UILabel!
    @IBOutlet private weak var devidedLoginView: UIView!
    @IBOutlet private weak var errorLoginLabel: UILabel!
    
    @IBOutlet private weak var passwordTF: UITextField!
    @IBOutlet private weak var passwordFloatingLabel: UILabel!
    @IBOutlet private weak var deviderPasswordLabel: UIView!
    @IBOutlet private weak var errorPasswordLabel: UILabel!
    
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var loadingIndicatorImage: UIImageView!
    
    @IBOutlet private weak var passwordSecurityButton: UIButton!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        configureLoginField()
        configurePasswordField()
        configureLoginButton()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
    }
    
    //MARK: - TouchesBegan
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Action Methods
    
    @IBAction func shadowPasswordAction(_ sender: UIButton) {
        passwordTF.isSecureTextEntry.toggle()
        if passwordTF.isSecureTextEntry {
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if keyboardUpConstraint.constant == 55 {
                keyboardUpConstraint.constant = 35
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardUpConstraint.constant == 35 {
            keyboardUpConstraint.constant = 55
        }
    }
}

//MARK: -  Private Method

extension TestAuthViewController {
    
    func configureLoginField() {
        
        loginTF.delegate = self
        loginTF.indent(size: 16)
        loginTF.backgroundColor = Constants.Color.textField
        loginTF.textContentType = .telephoneNumber
        loginTF.autocapitalizationType = .none
        loginTF.autocorrectionType = .no
        loginTF.keyboardType = .phonePad
        loginTF.returnKeyType = .next
        loginTF.font = .systemFont(ofSize: 18, weight: .regular)
        loginTF.tag = 0
        
        loginTF.clipsToBounds = true
        loginTF.layer.cornerRadius = 10
        loginTF.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        loginFloatingLabel.textColor = Constants.Color.placeHolderTF
        loginFloatingLabel.text = "Логин"
        loginFloatingLabel.font = .systemFont(ofSize: 16, weight: .regular)
        
        devidedLoginView.backgroundColor = Constants.Color.deviderTF
        
        errorLoginLabel.font = .systemFont(ofSize: 12)
        errorLoginLabel.textColor = Constants.Color.errorLabel
    }
    
    func configurePasswordField() {
        
        passwordTF.delegate = self
        passwordTF.indent(size: 16)
        passwordTF.backgroundColor = Constants.Color.textField
        passwordTF.textContentType = .password
        passwordTF.autocapitalizationType = .none
        passwordTF.autocorrectionType = .no
        passwordTF.isSecureTextEntry = true
        passwordTF.keyboardType = .default
        passwordTF.returnKeyType = .done
        passwordTF.font = .systemFont(ofSize: 18, weight: .regular)
        passwordTF.tag = 1
        
        passwordTF.clipsToBounds = true
        passwordTF.layer.cornerRadius = 10
        passwordTF.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        passwordFloatingLabel.textColor = Constants.Color.placeHolderTF
        passwordFloatingLabel.text = "Пароль"
        passwordFloatingLabel.font = .systemFont(ofSize: 16, weight: .regular)
        
        deviderPasswordLabel.backgroundColor = Constants.Color.deviderTF
        
        errorPasswordLabel.font = .systemFont(ofSize: 12)
        errorPasswordLabel.textColor = Constants.Color.errorLabel
        
        passwordSecurityButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        passwordSecurityButton.isHidden = true
        passwordSecurityButton.tintColor = Constants.Color.placeHolderTF
    }
    
    ///Floating Label
    func floatTitle(title: UILabel, constraint: NSLayoutConstraint) {
        title.font = .systemFont(ofSize: 12)
        constraint.constant = 4
    }
    
    func performAnimation(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.titleLabel.transform = transform
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func unfloatTitle(title: UILabel, constraint: NSLayoutConstraint) {
        constraint.constant = 18
        title.font = .systemFont(ofSize: 16)
        performAnimation(transform: CGAffineTransform(scaleX: 1, y: 1))
    }
    
    /// Configure login button
    func configureLoginButton() {
        loginButton.backgroundColor = .black
        loginButton.titleLabel?.textColor = .white
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        loginButton.setTitle("Войти", for: .normal)
        loadingIndicatorImage.image = Constants.Image.loadingIndicator
        loadingIndicatorImage.isHidden = true
        
    }
}

//MARK: - Extensions for Delegate

extension TestAuthViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        switch TextFieldTag(rawValue: textField.tag) {
        case .loginFieldTag:
            floatTitle(title: loginFloatingLabel, constraint: loginTopConstraint)
            performAnimation(transform: CGAffineTransform(scaleX: 1, y: 1))
        case .passwordFieldTag:
            floatTitle(title: passwordFloatingLabel, constraint: passwordTopConstraint)
            performAnimation(transform: CGAffineTransform(scaleX: 1, y: 1))
            passwordSecurityButton.isHidden = false
        case .none:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch TextFieldTag(rawValue: textField.tag) {
        case .loginFieldTag:
            if textField.text?.isEmpty ?? false {
                unfloatTitle(title: loginFloatingLabel, constraint: loginTopConstraint)
            }
        case .passwordFieldTag:
            if textField.text?.isEmpty ?? false {
                unfloatTitle(title: passwordFloatingLabel, constraint: loginTopConstraint)
                passwordSecurityButton.isHidden = true
            }
        case .none:
            break
        }
    }
}

