//
//  DetailContentTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 08.08.2022.
//

import UIKit

final class DetailContentTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var contentLabel: UILabel!
    
    //MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    //MARK: - Methods
    
    func configure(model: DetailItemModel) {
        contentLabel.text = model.content
    }
    
    //MARK: - Private Methods
    
    private func configureAppearance() {
        selectionStyle = .none
        contentLabel.font = .systemFont(ofSize: 12, weight: .light)
        contentLabel.numberOfLines = 0
        contentLabel.textColor = Constants.Color.appBlack
    }
    
}
