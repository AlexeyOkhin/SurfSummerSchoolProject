//
//  DetailImageViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 07.08.2022.
//

import UIKit

class DetailImageTableViewCell: UITableViewCell {
    
    //MARK: - UIView
    
    @IBOutlet private weak var cartImageView: UIImageView!
    
    //MARK: - Properties
    
    var imageUrlInString: String = "" {
        didSet {
            guard let url = URL(string: imageUrlInString) else {
                return
            }
            imageView?.loadImage(from: url)
        }
    }
    
    //MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    private func configureAppearance() {
        selectionStyle = .none
        cartImageView.layer.cornerRadius = 12
        cartImageView.contentMode = .scaleAspectFill
        //cartImageView.clipsToBounds = true
    }
    
}
