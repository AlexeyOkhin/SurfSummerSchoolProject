//
//  mainModel.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 04.08.2022.
//


import UIKit

final class MainModel {
    
    static let shared = MainModel.init()
    
    //MARK: - Events
    
    var didItemsUpdated: (() -> Void)?
    var didGetError: (() -> Void)?
    
    //MARK: - Propirties
    
    let pictureService = PicturesService()
    
    var items: [DetailItemModel] = []
    
    var errorMessage: String? {
        didSet {
            self.didGetError?()
        }
    }
    
    func loadPosts() {
        
        pictureService.loadPictures { [weak self] result in
            DispatchQueue.main.async {
            switch result {
            case .success(let pictures):
                self?.items = pictures.map { pictureModel in
                    
                    DetailItemModel(
                        id: pictureModel.id,
                        imageUrlInString: pictureModel.photoUrl,
                        title: pictureModel.title,
                        isFavorite: (try? FavoriteStorage().getIsFavoriteStatus(by: pictureModel.id)) ?? false,
                        content: pictureModel.content,
                        dateCreation: pictureModel.date
                    )
                }
                self?.didItemsUpdated?()
                
            case .failure(let error):
   
                
                    self?.errorMessage = error.localizedDescription
                
                
            }
            
            }
            
        }
    }
}


