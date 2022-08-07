//
//  DetailImageViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 07.08.2022.
//

import UIKit

class DetailImageViewCell: UITableViewCell {
    
//MARK: - UIView
    
    @IBOutlet private weak var cartImageView: UIImageView!
    
//MARK: - Properties
    
    var image: UIImage? {
        didSet {
            cartImageView.image = image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cartImageView.layer.cornerRadius = 12
        cartImageView.contentMode = .scaleAspectFill
    }
    
}
