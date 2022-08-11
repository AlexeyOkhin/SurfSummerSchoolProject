//
//  mainModel.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 04.08.2022.
//


import UIKit

final class MainModel {
    
    //MARK: - Events
    
    var didItemsUpdated: (() -> Void)?
    
    //MARK: - Propirties
    
    let pictureService = PicturesService()
    var items: [DetailItemModel] = [] {
        didSet {
            self.didItemsUpdated?()
        }
    }
    
    
    func loadPosts() {
        pictureService.loadPictures { [weak self] result in
            switch result {
            case .success(let pictures):
                self?.items = pictures.map { pictureModel in
                    DetailItemModel(
                        imageUrlInString: pictureModel.photoUrl,
                        title: pictureModel.title,
                        isFavorite: false, // TODO: - Need adding `FavoriteService`
                        content: pictureModel.content,
                        dateCreation: pictureModel.date
                    )
                }
            case .failure(let error):
                // TODO: - Implement error state there
                break
            }
        }
    }
}

