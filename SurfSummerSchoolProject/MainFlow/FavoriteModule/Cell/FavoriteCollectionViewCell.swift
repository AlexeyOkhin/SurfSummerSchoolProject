//
//  FavoriteCollectionViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 08.08.2022.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    //MARK: -  IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    //MARK: - Animation cell
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.contentView.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.96, y: 0.96) : .identity
            }
        }
    }
    
    //MARK: -  Properties
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var date: String? {
        didSet {
            dateLabel.text = date
        }
    }
    
    var content: String? {
        didSet {
            contentLabel.text = content
        }
    }
    
    //MARK: - Actions
    
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
    }
    
    //MARK: -  UICollectionViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearence()
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
}
