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
    
    var items: [DetailItemModel] = [] {
        
        didSet {
            self.didItemsUpdated?()
        }
    }
    
    //MARK: - Method
    /// net service
    func getPosts() {
        items = Array(repeating: DetailItemModel.createDefoult(), count: 100)
    }
}


