//
//  FavoriteCollectionViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 08.08.2022.
//

import UIKit

final class FavoriteCollectionViewCell: UICollectionViewCell {
    
    //MARK: -  IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var stackView: UIStackView!
    
    //MARK: - Private Property
    
    var tapForFavorites: (()-> Void)?
    
    //MARK: - Animation cell
    
    override var isHighlighted: Bool {
        didSet {
            animationTapCell()
        }
    }
    
    //MARK: - Actions
    
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        tapForFavorites?()
    }
    
    //MARK: -  UICollectionViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearence()
    }
    
    //MARK: - Methods
    
    func configure(model: DetailItemModel) {
        titleLabel.text = model.title
        contentLabel.text = model.content
        dateLabel.text = model.dateCreation
        let imageUrl = model.imageUrlInString
        guard let url = URL(string: imageUrl) else {
            return
        }
        imageView.loadImage(from: url)
//        isFavorite = model.isFavorite
//        favoriteButton.setImage(buttonImage, for: .normal)
    }

}

//MARK: - Private Methods

private extension FavoriteCollectionViewCell {

    func configureAppearence() {
        
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textColor = .black
        
        dateLabel.font = .systemFont(ofSize: 10, weight: .light)
        dateLabel.textColor = Constants.Color.dateText
        
        contentLabel.font = .systemFont(ofSize: 12)
        contentLabel.textColor = .black
        
        favoriteButton.tintColor = .white
        favoriteButton.setImage(Constants.Image.favoriteTrue, for: .normal )
    }
    
    func animationTapCell() {
        let cellReduction = CGAffineTransform(scaleX: 0.98, y: 0.98)
        UIView.animate(withDuration: 0.2) {
            self.contentView.transform = self.isHighlighted ? cellReduction : .identity
        }
    }
}
