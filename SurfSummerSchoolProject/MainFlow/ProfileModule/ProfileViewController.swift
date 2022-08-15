//
//  ProfileViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 03.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let model: MainModel = .init()
    //var photoCard: PhotoCard?

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
        
        NSLayoutConstraint.activate([
            photoCard.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80),
            photoCard.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            photoCard.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 16),
        ])
        
        
    }
    
    func setData() {
        
    }
}
