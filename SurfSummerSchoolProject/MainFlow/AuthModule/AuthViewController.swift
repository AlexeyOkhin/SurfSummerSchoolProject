//
//  TestAuthViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 17.08.2022.
//

import UIKit

final class AuthViewController: UIViewController {
    
    private enum TextFieldTag: Int {
        case loginFieldTag
        case passwordFieldTag
    }
    
    //MARK: - IBUutlet constraints
    
    @IBOutlet private weak var contentUpConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var passwordTitleLabelMoveTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var loginLabelMoveTopConstraint: NSLayoutConstraint!
    
    //MARK: - IBOutlets Views
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var surfBackgrroundImage: UIImageView!
    
    @IBOutlet private weak var loginTF: UITextField!
    @IBOutlet private weak var loginFloatingLabel: UILabel!
    @IBOutlet private weak var devidedLoginTextField: UIView!
    @IBOutlet private weak var errorLoginLabel: UILabel!
    
    @IBOutlet private weak var passwordTF: UITextField!
    @IBOutlet private weak var passwordFloatingLabel: UILabel!
    @IBOutlet private weak var deviderPasswordTextField: UIView!
    @IBOutlet private weak var errorPasswordLabel: UILabel!
    
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var loadingIndicatorImage: UIImageView!
    
    @IBOutlet private weak var passwordSecurityButton: UIButton!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Вход"
        setKeyboardNotification()
        configureErrorTextField(for: errorLoginLabel)
        configureErrorTextField(for: errorPasswordLabel)
        configureAuthTextField(for: loginTF, with: .phonePad, isSecureTextEntry: false, returnKeyType: .next, tag: .loginFieldTag)
        configureAuthTextField(for: passwordTF, with: .default, isSecureTextEntry: true, returnKeyType: .done, tag: .passwordFieldTag)
        configureFloatingLabel(for: loginFloatingLabel, with: "Логин")
        configureFloatingLabel(for: passwordFloatingLabel, with: "Пароль")
        configurePasswordSecurityButton()
        configureDeviderTextField()
        configureLoginButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        removeKeyboardNotification()
    }
    
    //MARK: - TouchesBegan
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    //MARK: - Action Methods
    
    @IBAction private func shadowPasswordAction(_ sender: UIButton) {
        passwordTF.isSecureTextEntry.toggle()
        passwordTF.isSecureTextEntry ? sender.setImage(Constants.Image.closeEye, for: .normal)
                                    : sender.setImage(Constants.Image.openEye, for: .normal)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if contentUpConstraint.constant == Constants.Size.contentShiftNormal {
                contentUpConstraint.constant = Constants.Size.contentShiftUp
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if contentUpConstraint.constant == Constants.Size.contentShiftUp {
            contentUpConstraint.constant = Constants.Size.contentShiftNormal
        }
    }
}

//MARK: -  Private Method

private extension AuthViewController {
    
    func configureFloatingLabel(for label: UILabel, with title: String) {
        label.textColor = Constants.Color.placeHolderTF
        label.text = title
        label.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    func configureErrorTextField(for label: UILabel) {
        label.font = .systemFont(ofSize: 12)
        label.textColor = Constants.Color.errorLabel
        label.isHidden = true
    }
    
    private func configureAuthTextField(for textField: UITextField, with keyboardType: UIKeyboardType, isSecureTextEntry: Bool, returnKeyType: UIReturnKeyType, tag: TextFieldTag) {
        
        textField.delegate = self
        textField.leftPadding(size: 16)
        textField.backgroundColor = Constants.Color.textField
        //textField.textContentType = .none
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = isSecureTextEntry
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType
        textField.font = .systemFont(ofSize: 18, weight: .regular)
        textField.tag = tag.rawValue

        textField.clipsToBounds = true
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func configureDeviderTextField() {
        deviderPasswordTextField.backgroundColor = Constants.Color.deviderTF
        devidedLoginTextField.backgroundColor = Constants.Color.deviderTF
    }
    
    func configurePasswordSecurityButton() {
        passwordSecurityButton.setImage(Constants.Image.closeEye, for: .normal)
        passwordSecurityButton.isHidden = true
        passwordSecurityButton.tintColor = Constants.Color.placeHolderTF
    }
    
    func setKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
    }
    
    func movingUp(for titleTextFieldLabel: UILabel, to topConstraintLabel: NSLayoutConstraint) {
        titleTextFieldLabel.font = .systemFont(ofSize: 12)
        topConstraintLabel.constant = Constants.Size.labelMoveUpConstraint
        performAnimation(transform: CGAffineTransform(scaleX: 1, y: 1), for: titleTextFieldLabel)
    }
    
    func movingDown(for titleTextFieldLabel: UILabel, to topConstraintLabel: NSLayoutConstraint) {
        titleTextFieldLabel.font = .systemFont(ofSize: 16)
        topConstraintLabel.constant = Constants.Size.labelMoveDownConstraint
        performAnimation(transform: CGAffineTransform(scaleX: 1, y: 1), for: titleTextFieldLabel)
    }
    
    func performAnimation(transform: CGAffineTransform, for titleTextFieldLabel: UILabel) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            titleTextFieldLabel.transform = transform
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func configureButtonActivityIndicator() {
        loadingIndicatorImage.image = Constants.Image.loadingIndicator
        loadingIndicatorImage.isHidden = true
    }
    
    func configureLoginButton() {
        loginButton.backgroundColor = .black
        loginButton.titleLabel?.textColor = .white
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        loginButton.setTitle("Войти", for: .normal)
        
        configureButtonActivityIndicator()
        
    }
}

//MARK: - Extensions for Delegate

extension AuthViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        switch TextFieldTag(rawValue: textField.tag) {
        case .loginFieldTag:
            movingUp(for: loginFloatingLabel, to: loginLabelMoveTopConstraint)
            
        case .passwordFieldTag:
            movingUp(for: passwordFloatingLabel, to: passwordTitleLabelMoveTopConstraint)
            passwordSecurityButton.isHidden = false
        case .none:
            break
        }
    }
    
    func movingDownLabelIfTextFieldIsEmpty(_ textField: UITextField) {
        switch TextFieldTag(rawValue: textField.tag) {
        case .loginFieldTag:
            if textField.text?.isEmpty ?? false {
                movingDown(for: loginFloatingLabel, to: loginLabelMoveTopConstraint)
            }
        case .passwordFieldTag:
            if textField.text?.isEmpty ?? false {
                movingDown(for: passwordFloatingLabel, to: passwordTitleLabelMoveTopConstraint)
                passwordSecurityButton.isHidden = true
            }
        case .none:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        movingDownLabelIfTextFieldIsEmpty(textField)
    }
}

