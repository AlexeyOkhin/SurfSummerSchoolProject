//
//  MainEmptyState.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 11.08.2022.
//

import UIKit

class MainEmptyState: UIView {
    
    init(imageEmpty: UIImageView, label: UILabel, button: UIButton) {
        super.init(frame: .zero)
        
        label.numberOfLines = 2
        label.textAlignment = .center
        
        
        translatesAutoresizingMaskIntoConstraints = false
        imageEmpty.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageEmpty)
        addSubview(label)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            imageEmpty.topAnchor.constraint(equalTo: self.topAnchor),
            imageEmpty.widthAnchor.constraint(equalToConstant: 27),
            imageEmpty.heightAnchor.constraint(equalToConstant: 27),
            imageEmpty.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            
        ])

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageEmpty.bottomAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 24),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 48)
        ])

        bottomAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
    }
//
//    let imageEmpty: UIImageView = {
//        let image = UIImageView()
//        image.image = Constants.Image.emptyMain
//        image.contentMode = .center
//        image.clipsToBounds = true
//        image.translatesAutoresizingMaskIntoConstraints = false
//       return image
//    }()
//
//    let messageLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Не удалось загрузить ленту \n Обновите экран или попробуйте позже"
//        label.font = .systemFont(ofSize: 14)
//        label.numberOfLines = 2
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    let restartButton: UIButton = {
//        let button = UIButton(title: "Restart", backgroundCollor: .black, titleColor: .white)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubview(imageEmpty)
//        addSubview(messageLabel)
//        addSubview(restartButton)
//        setupConstraints()
//    }
//
//    private func setupConstraints() {
//        translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            imageEmpty.topAnchor.constraint(equalTo: self.topAnchor),
//            imageEmpty.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            imageEmpty.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            imageEmpty.heightAnchor.constraint(equalToConstant: 27),
//            imageEmpty.widthAnchor.constraint(equalToConstant: 27)
//        ])
//
//        NSLayoutConstraint.activate([
//            messageLabel.topAnchor.constraint(equalTo: imageEmpty.bottomAnchor, constant: 16),
//            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
//        ])
//
//        NSLayoutConstraint.activate([
//            restartButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 24),
//            restartButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            restartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            restartButton.heightAnchor.constraint(equalToConstant: 48)
//
//        ])
//
//        self.bottomAnchor.constraint(equalTo: restartButton.bottomAnchor).isActive = true
//        self.trailingAnchor.constraint(equalTo: restartButton.trailingAnchor).isActive = true
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
