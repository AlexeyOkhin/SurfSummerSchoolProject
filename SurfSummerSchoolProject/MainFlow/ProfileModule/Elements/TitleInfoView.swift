//
//  TitleInfoView.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 15.08.2022.
//

import UIKit


final class TitleInfoView: UIView {
    init(titleLabel: UILabel, subtitleLabel: UILabel) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = Constants.Color.dateText
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.numberOfLines = 1
        subtitleLabel.font = UIFont.systemFont(ofSize: 18)
        subtitleLabel.textColor = Constants.Color.appBlack
        
        let bottomBorder = UIView(frame: .zero)
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(bottomBorder)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
        ])
        
        NSLayoutConstraint.activate([
            bottomBorder.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 18),
            bottomBorder.leftAnchor.constraint(equalTo: self.leftAnchor),
            bottomBorder.rightAnchor.constraint(equalTo: self.rightAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        bottomAnchor.constraint(equalTo: bottomBorder.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
