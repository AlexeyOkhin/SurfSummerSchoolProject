//
//  DetailItemModel.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 07.08.2022.
//

import UIKit

struct DetailItemModel {
    
    // MARK: - Properties
    let id: String
    let imageUrlInString: String
    let title: String
    var isFavorite: Bool
    let content: String
    let dateCreation: String
    
    // MARK: - Initialization

    internal init(id: String, imageUrlInString: String, title: String, isFavorite: Bool, content: String, dateCreation: Date) {
        self.id = id
        self.imageUrlInString = imageUrlInString
        self.title = title
        self.isFavorite = isFavorite
        self.content = content

        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"

        self.dateCreation = formatter.string(from: dateCreation)
    }
}
