//
//  DetailTitleTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 07.08.2022.
//

import UIKit

final class DetailTitleTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var cartTitleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!

    //MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    //MARK: - Methods
    
    func configure(model: DetailItemModel) {
        cartTitleLabel.text = model.title
        dateLabel.text = model.dateCreation
    }
    
    //MARK: - Private Methods
    
    private func configureAppearance() {
        selectionStyle = .none
        cartTitleLabel.font = .systemFont(ofSize: 16)
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = Constants.Color.dateText
    }
}
