//
//  mainModel.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 04.08.2022.
//


import UIKit

final class MainModel {
    
    //MARK: - Propirties
    
    static let shared = MainModel.init()
    
    let pictureService = PicturesService()
    
    var items: [DetailItemModel] = [] {
        didSet {
            self.didItemsUpdated?()
        }
    }
    var errorMessage: String? {
        didSet {
            self.didGetError?()
        }
    }
    //MARK: - Events
    
    var didItemsUpdated: (() -> Void)?
    var didGetError: (() -> Void)?
    
    
    
    func loadPosts() {
        pictureService.loadPictures { [weak self] result in
            switch result {
            case .success(let pictures):
                self?.items = pictures.map { pictureModel in
                    DetailItemModel(
                        id: pictureModel.id,
                        imageUrlInString: pictureModel.photoUrl,
                        title: pictureModel.title,
                        isFavorite: FavoritesManager.shared.rowsWhichAreChecked.contains(pictureModel.id) ? true : false, // TODO: - Need adding `FavoriteService`
                        content: pictureModel.content,
                        dateCreation: pictureModel.date
                    )
                }
            case .failure(let error):
                
                // TODO: - Implement error state there
                
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                }
                
            }
            
        }
    }
}


