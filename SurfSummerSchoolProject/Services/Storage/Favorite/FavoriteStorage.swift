//
//  FavoriteStorage.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 14.08.2022.
//

import Foundation

protocol FavoriteStorage {

    func loadFavorite() throws -> [FavoriteModel]
    func save(newFavorite: FavoriteModel) throws

}
