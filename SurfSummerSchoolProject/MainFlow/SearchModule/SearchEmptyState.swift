//
//  SearchEmptyState.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 21.08.2022.
//

import UIKit

class SearchEmptyState: UIView {
    
    init(imageEmpty: UIImageView, label: UILabel) {
        super.init(frame: .zero)
        
        label.numberOfLines = 2
        label.textAlignment = .center
        
        translatesAutoresizingMaskIntoConstraints = false
        imageEmpty.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageEmpty)
        addSubview(label)
        
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


        bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

