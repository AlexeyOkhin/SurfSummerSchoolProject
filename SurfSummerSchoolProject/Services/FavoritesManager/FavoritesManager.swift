//
//  FavoritesManager.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 14.08.2022.
//

import Foundation

class FavoritesManager {
    
    // Singleton
    static let shared = FavoritesManager()
    
    private var favoritePicture = [FavoriteModel]()
    var rowsWhichAreChecked = UserDefaults.standard.array(forKey: "picturesFavorite") as? [String] ?? [String]()
    
    func addPicture(picture: FavoriteModel) {
        favoritePicture.append(picture)
        //save()
    }
    
    func deletePictureAtIndex(index: Int) {
        favoritePicture.remove(at: index)
        //save()
    }
    
    func pictureAtIndex(index: Int) -> FavoriteModel? {
        return favoritePicture[index]
    }
    
    func pictureCount() -> Int {
        return favoritePicture.count
    }
    
   
}
