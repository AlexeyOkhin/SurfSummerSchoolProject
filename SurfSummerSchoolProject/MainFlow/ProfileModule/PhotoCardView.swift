//
//  PhotoCardView.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 14.08.2022.
//

import UIKit

class PhotoCard: UIView {
    let photoImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderColor = UIColor.black.cgColor
        //image.layer.cornerRadius = 12
        //image.layer.borderWidth = 1
       return image
    }()
    
    let fioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    let aboutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 12)
        label.textColor = Constants.Color.dateText
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(photoImageView)
        addSubview(fioLabel)
        addSubview(aboutLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 128),
            photoImageView.widthAnchor.constraint(equalToConstant: 128)
        ])
        
        NSLayoutConstraint.activate([
            fioLabel.topAnchor.constraint(equalTo: self.topAnchor),
            fioLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 16),
            fioLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            aboutLabel.topAnchor.constraint(equalTo: fioLabel.bottomAnchor, constant: 8),
            aboutLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 16),
            aboutLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 24)
        ])
        
        
        self.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: fioLabel.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(name: String, about: String, photo: UIImage){
        self.init()
        photoImageView.image = photo
        aboutLabel.text = about
        fioLabel.text = name
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.layer.masksToBounds = true
        photoImageView.layer.cornerRadius = 12

    }
}
