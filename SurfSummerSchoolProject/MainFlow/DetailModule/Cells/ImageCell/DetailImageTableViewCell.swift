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
    
    var image: UIImage? {
        didSet {
            cartImageView.image = image
        }
    }
    
    //MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        cartImageView.layer.cornerRadius = 12
        cartImageView.contentMode = .scaleAspectFill
        cartImageView.clipsToBounds = true
    }
    
}
