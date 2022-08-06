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
    
    var items: [ItemModel] = [] {
        
        didSet {
            self.didItemsUpdated?()
        }
    }
    
    //MARK: - Method
    /// net service
    func getPosts() {
        items = Array(repeating: ItemModel.createDefoult(), count: 100)
    }
}

struct ItemModel {
    let image: UIImage?
    let title: String
    var isFavorite: Bool
    let dateCreate: String
    let content: String
    
    static func createDefoult() -> ItemModel {
        .init(image: Constants.Image.testKogi, title: "Корги", isFavorite: false, dateCreate: "12.12.2021", content: "Для бариста и посетителей кофеен специальные кружки для кофе — это ещё один способ проконтролировать вкус напитка и приготовить его именно так, как нравится вам. Теперь, кроме регулировки")
    }
}
