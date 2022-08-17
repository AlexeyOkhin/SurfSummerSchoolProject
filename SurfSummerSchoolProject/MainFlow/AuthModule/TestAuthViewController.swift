//
//  TestAuthViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 17.08.2022.
//

import UIKit

enum TextFieldTag: Int {
    case loginFieldTag = 0
    case passwordFieldTag = 1
}

class TestAuthViewController: UIViewController {
    
    
    
    
    //MARK: - IBUutlet constraints
    
    @IBOutlet private weak var keybordUpConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var passwordLeftConstraint: NSLayoutConstraint!
    @IBOutlet private weak var passwordTopConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var loginTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var loginLeftConstraint: NSLayoutConstraint!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLoginField()
        configurePasswordField()
       
        
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
        case .none:
            break
        }
    }
    
    func floatTitle(title: UILabel, constraint: NSLayoutConstraint) {
        title.font = .systemFont(ofSize: 12)
        constraint.constant = 4
    }
    
    private func performAnimation(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.titleLabel.transform = transform
            self.view.layoutIfNeeded()
        }, completion: nil)
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
               }
           case .none:
               break
           }
       }

      func unfloatTitle(title: UILabel, constraint: NSLayoutConstraint) {
          constraint.constant = 18
          title.font = .systemFont(ofSize: 16)
          performAnimation(transform: CGAffineTransform(scaleX: 1, y: 1))
       }

}

