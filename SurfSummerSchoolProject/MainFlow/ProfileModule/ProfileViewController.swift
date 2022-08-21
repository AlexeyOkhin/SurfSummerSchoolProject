//
//  ProfileViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 03.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - Private Property
    
    private var infoItem: UserInfo?
    @IBOutlet private weak var activityIndicator: UIImageView!
    @IBOutlet private weak var logoutButton: UIButton!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        configureAppearence()
        
    }
    
    //MARK: - Private Action
    
    @IBAction private func logoutAction(_ sender: UIButton) {
        
        exitAction()
    }
    
}

//MARK: - Private Methods

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
        

        logoutButton.setTitle("Выход", for: .normal)
        logoutButton.backgroundColor = Constants.Color.appBlack
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        logoutButton.titleLabel?.textColor = Constants.Color.appWhite
        
        activityIndicator.image = Constants.Image.loadingIndicator
        activityIndicator.isHidden = true
        
        
        
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
        
    }
    
    @objc func exitAction() {
        
        let alert = UIAlertController(title: "Внимание", message: "Вы точно хотите выйти из приложения?", preferredStyle: .alert)
        let buttonActionCancel = UIAlertAction(title: "Нет", style: .cancel)
        let buttonActionAccept = UIAlertAction(title: "Да, точно", style: .default) { _ in
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
        } catch let error{
            print(error)
        }
    }
    
    func logout() {
        logoutButton.titleLabel?.isHidden = true
        activityIndicator.startAnimationLoading()
        AuthService().performLogoutRequestWithResetData(credentials: EmptyModel(), { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    do {
                        try FavoriteStorage().resetFavoriteStorage()
                        try UserInfoStorage().resetUserStorage()
                    } catch let error {
                        print(error)
                    }
                    self.activityIndicator.stopAnimationLoading()
                    let authViewController = AuthViewController()
                    authViewController.modalPresentationStyle = .fullScreen
                    self.present(authViewController, animated: true)
                case .failure:
                    print("ErrorPointer")
                    self.logoutButton.titleLabel?.isHidden = true
                    self.activityIndicator.stopAnimationLoading()
                }
            }
        })
    }
}
