//
//  MainCollectionViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 04.08.2022.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOUTlet

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
   
    //MARK: - Events
    
    var didFavoriteTapped: (() -> Void)?
    //MARK: - Calculated
    
    var buttonImage: UIImage? {
        return isFavorite ? Constants.Image.favoriteTrue : Constants.Image.favoriteFalse
    }
    
    //MARK: - Properties
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var isFavorite: Bool = false {
        didSet {
            favoriteButton.setImage(buttonImage, for: .normal)
        }
    }
    
    //MARK: - Actions
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        didFavoriteTapped?()
        isFavorite.toggle()
    }
    
    //MARK: - UICollectionViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearence()
    }

}

//MARK: - Private Methods

private extension MainCollectionViewCell {
    
    func configureAppearence() {
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 12)
        
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        
        favoriteButton.tintColor = .white
        
        isFavorite = false
    }
}
