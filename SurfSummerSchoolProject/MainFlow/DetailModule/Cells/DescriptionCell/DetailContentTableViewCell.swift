//
//  DetailContentTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 08.08.2022.
//

import UIKit

class DetailContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    
    var content: String? {
        didSet {
            contentLabel.text = content
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    private func configureAppearance() {
        selectionStyle = .none
        contentLabel.font = .systemFont(ofSize: 12, weight: .light)
        contentLabel.numberOfLines = 0
        contentLabel.textColor = .black
    }
    
}
