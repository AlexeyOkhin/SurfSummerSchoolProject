//
//  ProfileViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 03.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var infoItem: UserInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        configureAppearence()
    }
}

private extension ProfileViewController {
    func configureAppearence() {
        guard let item = infoItem else { return }
        let fullName = (item.firstName + " " + item.lastName)
        
        guard let url = URL(string: item.avatar) else {
            return
        }
        let photoCard = PhotoCard(name: fullName, about: item.about, photoUrl: url)
        self.view.addSubview(photoCard)
        photoCard.translatesAutoresizingMaskIntoConstraints = false
        
        let nameTitleCity = UILabel(name: "Город")
        let nameCyty = UILabel(name: item.city)
        let cityLabelBorder = TitleInfoView(titleLabel: nameTitleCity, subtitleLabel: nameCyty)
        
        let nameTitlePhone = UILabel(name: "Телефон")
        let phoneLabel = UILabel(name: item.phone.applyPatternOnNumbers(pattern: "+# (###) ### ## ##", replacementCharacter: "#"))
        let phoneLabelBorder = TitleInfoView(titleLabel: nameTitlePhone, subtitleLabel: phoneLabel)
        
        let nameTitleEmail = UILabel(name: "Почта")
        let emailLabel = UILabel(name: item.email)
        let emailLabelBorder = TitleInfoView(titleLabel: nameTitleEmail, subtitleLabel: emailLabel)

        let stackView = UIStackView(arrangedSubviews: [cityLabelBorder, phoneLabelBorder, emailLabelBorder])
        stackView.axis = .vertical
        stackView.spacing = 34
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        let exitButton = UIButton(title: "Выйти", backgroundCollor: .black, titleColor: .white)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.addTarget(self, action: #selector(exitAction), for: .touchUpInside)
        self.view.addSubview(exitButton)
        
        NSLayoutConstraint.activate([
            photoCard.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 35),
            photoCard.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            photoCard.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: photoCard.bottomAnchor, constant: 26),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            exitButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            exitButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            exitButton.heightAnchor.constraint(equalToConstant: 48),
            exitButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
    
    @objc func exitAction() {
        
        let alert = UIAlertController(title: "Внимание", message: "Вы точно хотите выйти из приложения?", preferredStyle: .alert)
        let buttonActionCancel = UIAlertAction(title: "Нет", style: .cancel)
        let buttonActionAccept = UIAlertAction(title: "Да, точно", style: .default) { _ in
            print("Logic Exit")
            self.logout()
        }
        alert.addAction(buttonActionCancel)
        alert.addAction(buttonActionAccept)
        alert.preferredAction = buttonActionAccept
        self.present(alert, animated: true)
    }
    
    func getData() {
        do {
            infoItem = try UserInfoStorage().getUserInfo()
        } catch {
            
        }
    }
    
    func logout() {
        
        AuthService().performLogoutRequestWithResetData(credentials: EmptyModel(), { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("succc")
                    let authVC = AuthViewController()
                    authVC.modalPresentationStyle = .fullScreen
                    self.present(authVC, animated: true)
                case .failure:
                    print("ErrorPointer")
                }
            }
        })
    }
}
