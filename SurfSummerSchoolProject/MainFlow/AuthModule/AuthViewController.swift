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
    
    //MARK: - Private IBOutlets
    
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
    
    //MARK: - Private Properties
    
    private var errorLoginView: UIView = {
        UIView(frame: .zero)
    }()
    
    private var regExp: NSRegularExpression?
    private let maxNumerCountInLogin = 11
    private let maxPasswordLength = 15
    private var isShownError = false
    
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        setKeyboardNotification()
        configureErrorTextField(for: errorLoginLabel)
        configureErrorTextField(for: errorPasswordLabel)
        configureAuthTextField(for: loginTF, with: .numberPad, isSecureTextEntry: false, tag: .loginFieldTag)
        configureAuthTextField(for: passwordTF, with: .default, isSecureTextEntry: true, tag: .passwordFieldTag)
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
    
    @IBAction private func loginButtonAction(_ sender: UIButton) {
        registrationAttempt()
    }
    
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
    
    func configureTitle() {
        titleLabel.text = "Вход"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    
    func configureFloatingLabel(for label: UILabel, with title: String) {
        label.textColor = Constants.Color.placeHolderTF
        label.text = title
        label.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    func configureErrorTextField(for label: UILabel) {
        label.font = .systemFont(ofSize: 12)
        label.textColor = Constants.Color.errorLabel
        label.isHidden = true
        label.text = "Поле не может быть пустым"
    }
    
    private func configureAuthTextField(for textField: UITextField, with keyboardType: UIKeyboardType, isSecureTextEntry: Bool, tag: TextFieldTag) {
        
        textField.delegate = self
        textField.leftPadding(size: 16)
        textField.backgroundColor = Constants.Color.textField
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = isSecureTextEntry
        textField.keyboardType = keyboardType
        textField.returnKeyType = .done
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
        loadingIndicatorImage.contentMode = .scaleAspectFill
    }
    
    func configureLoginButton() {
        loginButton.backgroundColor = Constants.Color.appBlack
        loginButton.titleLabel?.textColor = Constants.Color.appWhite
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        loginButton.setTitle("Войти", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        configureButtonActivityIndicator()
    }
    
    func showErrorEmptyTextField() {
        errorLoginLabel.isHidden = !(loginTF.text?.isEmpty ?? true)
        errorPasswordLabel.isHidden = !(passwordTF.text?.isEmpty ?? true)
        devidedLoginTextField.backgroundColor = loginTF.text?.isEmpty ?? true
        ? Constants.Color.errorLabel
        : Constants.Color.deviderTF
        deviderPasswordTextField.backgroundColor = passwordTF.text?.isEmpty ?? true
        ? Constants.Color.errorLabel
        : Constants.Color.deviderTF
    }
    
    func isInputCorrect() -> Bool {
        if loginTF.text?.isEmpty ?? true || passwordTF.text?.isEmpty ?? true{
            showErrorEmptyTextField()
            return false
        } else {
            loginButton.titleLabel?.isHidden = true
            devidedLoginTextField.backgroundColor = Constants.Color.deviderTF
            deviderPasswordTextField.backgroundColor = Constants.Color.deviderTF
            loadingIndicatorImage.startAnimationLoading()
            return true
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
    
    func formate(phoneNumber: String, shouldRemoveLastDigit: Bool) -> String {
        guard !(shouldRemoveLastDigit && phoneNumber.count <= 2) else { return "+" }
        
        do {
            regExp = try NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)
        } catch let error {
            return error.localizedDescription
        }
        let range = NSString(string: phoneNumber).range(of: phoneNumber)
        guard let regExp = regExp else { return ""}
        var number = regExp.stringByReplacingMatches(in: phoneNumber,options: [], range: range, withTemplate: "")
        
        if number.count > maxNumerCountInLogin {
            let maxIndex = number.index(number.startIndex, offsetBy: maxNumerCountInLogin)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        if shouldRemoveLastDigit {
            let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        let maxIndex = number.index(number.startIndex, offsetBy: number.count)
        let regRange = number.startIndex..<maxIndex
        
        if number.count < 7 {
            let pattern = "(\\d)(\\d{3})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3", options: .regularExpression, range: regRange)
        } else {
            let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3 $4 $5", options: .regularExpression, range: regRange)
        }
        return "+" + number
    }
    
    func formatedInputIn(textField: UITextField, replacementString string: String, shouldChangeCharactersIn range: NSRange) {
        let fullString = (textField.text ?? "") + string
        textField.text = formate(phoneNumber: fullString, shouldRemoveLastDigit: range.length == 1)
    }
    
    func inputRestrictFor(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, maxRestrict: Int) -> Bool {
        let fullString = textField.text?.count ?? 0
        if range.length + range.location > fullString {
            return false
        }
        let inputLength = fullString + string.count - range.length
        return inputLength <= maxRestrict
    }
    
    func showErrorLogin(withMessage message: String) {
        isShownError = true
        errorLoginView = UIView(frame: .zero)
        view.addSubview(errorLoginView)
        errorLoginView.backgroundColor = Constants.Color.errorNavBar
        errorLoginView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = message
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = Constants.Color.appWhite
        titleLabel.backgroundColor = Constants.Color.errorNavBar
        
        NSLayoutConstraint.activate([
            errorLoginView.topAnchor.constraint(equalTo: self.view.topAnchor),
            errorLoginView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            errorLoginView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            errorLoginView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor)
        ])
    }
    
    func resetErrorLogin(if isError: inout Bool, setTitle: String ) {
        if isError {
            errorLoginView.removeFromSuperview()
            titleLabel.text = setTitle
            titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            titleLabel.textColor = Constants.Color.appBlack
            titleLabel.backgroundColor = Constants.Color.appWhite
            isError = false
        }
    }
    
    func registrationAttempt() {
        if isInputCorrect() {
            view.endEditing(true)
            loginButton.titleLabel?.isHidden = true
            let loginFormate = loginTF.text?.applyPatternOnNumbers(pattern: "+###########", replacementCharacter: "#") ?? ""
            let passwordText = passwordTF.text ?? ""
            let tempCredentials = AuthRequestModel(phone: loginFormate, password: passwordText)
            AuthService().performLoginRequestAndSaveToken(credentials: tempCredentials) { [weak self] result in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    switch result {
                        
                    case .success:
                        let mainTabBar = TabBarConfigurator().configure()
                        mainTabBar.modalPresentationStyle = .fullScreen
                        self?.present(mainTabBar, animated: true)
                        self?.loadingIndicatorImage.stopAnimationLoading()
                        
                    case .failure:
                        self?.loginButton.titleLabel?.isHidden = false
                        self?.loadingIndicatorImage.stopAnimationLoading()
                        self?.showErrorLogin(withMessage: "Логин или пароль введен неправильно")
                        // TODO: - Handle error, if token was not received
                        break
                    }
                }
                )}
        }
    }
}

//MARK: - Extensions for Delegate

extension AuthViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        movingDownLabelIfTextFieldIsEmpty(textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        resetErrorLogin(if: &isShownError, setTitle: "Вход")
        
        switch TextFieldTag(rawValue: textField.tag) {
            
        case .loginFieldTag:
            
            errorLoginLabel.isHidden = true
            devidedLoginTextField.backgroundColor = Constants.Color.deviderTF
            movingUp(for: loginFloatingLabel, to: loginLabelMoveTopConstraint)
            formatedInputIn(textField: textField, replacementString: string, shouldChangeCharactersIn: range)
            return false
            
        case .passwordFieldTag:
            errorPasswordLabel.isHidden = true
            deviderPasswordTextField.backgroundColor = Constants.Color.deviderTF
            movingUp(for: passwordFloatingLabel, to: passwordTitleLabelMoveTopConstraint)
            passwordSecurityButton.isHidden = false
            return inputRestrictFor(textField: textField, shouldChangeCharactersIn: range, replacementString: string, maxRestrict: maxPasswordLength)
        case .none:
            break
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        registrationAttempt()
        return true
    }
}

