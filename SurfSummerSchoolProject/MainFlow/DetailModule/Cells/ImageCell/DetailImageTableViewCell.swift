//
//  DetailImageViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 07.08.2022.
//

import UIKit

final class DetailImageTableViewCell: UITableViewCell {
    
    //MARK: - UIView
    
    @IBOutlet private weak var cartImageView: UIImageView!
    
    //MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cartImageView.image = nil
    }
    
    func configure(model: DetailItemModel) {
        guard let url = URL(string: model.imageUrlInString) else {
            return
        }
        cartImageView?.loadImage(from: url)
    }

    private func configureAppearance() {
        selectionStyle = .none
        cartImageView.layer.cornerRadius = 12
        cartImageView.contentMode = .scaleAspectFill
    }
}
