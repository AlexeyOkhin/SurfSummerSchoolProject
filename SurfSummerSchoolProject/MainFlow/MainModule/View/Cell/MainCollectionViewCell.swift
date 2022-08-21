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
    
//    var buttonImage: UIImage? {
//        return isFavorite ? Constants.Image.favoriteTrue : Constants.Image.favoriteFalse
//    }
    
    //MARK: - Animation cell
    
    override var isHighlighted: Bool {
        didSet {
           animationTapCell()
        }
    }
    
    //MARK: - Properties

    var isFavorite: Bool = false {
        didSet {
            let image = isFavorite ? Constants.Image.favoriteTrue : Constants.Image.favoriteFalse
            favoriteButton.setImage(image , for: .normal)
        }
    }
    //MARK: - Actions
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        
        //isFavorite.toggle()
        didFavoriteTapped?()
    }
    
    //MARK: - UICollectionViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearence()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    //MARK: - Methods
    
    func configure(model: DetailItemModel) {
        titleLabel.text = model.title
        
        let imageUrl = model.imageUrlInString
        guard let url = URL(string: imageUrl) else {
            return
        }
        imageView.loadImage(from: url)
        isFavorite = model.isFavorite
        //favoriteButton.setImage(buttonImage, for: .normal)
    }

}

    //MARK: - Private Methods

private extension MainCollectionViewCell {
    
    func configureAppearence() {
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 12)
        
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        
        favoriteButton.tintColor = .white
        
        favoriteButton.imageView?.image = Constants.Image.favoriteFalse
    }
    
    func animationTapCell() {
        let cellReduction = CGAffineTransform(scaleX: 0.98, y: 0.98)
        UIView.animate(withDuration: 0.2) {
            self.contentView.transform = self.isHighlighted ? cellReduction : .identity
        }
    }
}

