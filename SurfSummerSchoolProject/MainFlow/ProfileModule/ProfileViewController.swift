//
//  ProfileViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 03.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let model: MainModel = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearence()
        setData()
    }
}

private extension ProfileViewController {
    func configureAppearence() {
        
        let photoCard = PhotoCard(name: "afdsdf", about: "aqwdewdewf", photo: Constants.Image.testKogi)
        self.view.addSubview(photoCard)
        photoCard.translatesAutoresizingMaskIntoConstraints = false
        
        let nameTitleCity = UILabel(name: "Город")
        let nameCyty = UILabel(name: "Оренбург")
        let cityLabelBorder = TitleInfoView(titleLabel: nameTitleCity, subtitleLabel: nameCyty)
        
        let nameTitlePhone = UILabel(name: "Телефон")
        let phoneLabel = UILabel(name: "+7 922 62 17 681") // форматировать перед вставкой
        let phoneLabelBorder = TitleInfoView(titleLabel: nameTitlePhone, subtitleLabel: phoneLabel)
        
        let nameTitleEmail = UILabel(name: "Почта")
        let emailLabel = UILabel(name: "killer@list.ru")
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
        print("EXIT FUNC")
    }
    
    func setData() {
        
    }
}
