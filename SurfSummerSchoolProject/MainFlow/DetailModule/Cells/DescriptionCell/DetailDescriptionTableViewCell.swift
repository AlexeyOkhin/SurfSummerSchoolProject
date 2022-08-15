//
//  DeatailDescriptionTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 07.08.2022.
//

import UIKit

class DetailDescriptionTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var contentLabel: UILabel!
    
    //MARK: - Propirtes
    
    var content: String? {
        didSet {
            contentLabel.text = content
        }
    }
    
    //MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    //MARK: - Private Methods
    
    private func configureAppearance() {
        selectionStyle = .none
        contentLabel.numberOfLines = 0
        contentLabel.font = .systemFont(ofSize: 12, weight: .light)
        contentLabel.textColor = .black
    }
}
