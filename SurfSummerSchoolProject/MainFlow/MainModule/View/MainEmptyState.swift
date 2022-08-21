//
//  MainEmptyState.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 11.08.2022.
//

import UIKit

final class MainEmptyState: UIView {
    
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
