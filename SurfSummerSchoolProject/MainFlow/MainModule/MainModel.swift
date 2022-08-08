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
    
    func getFavoritePosts() {
        items = [
        DetailItemModel(image: Constants.Image.testKogi, title: "Корги", isFavorite: true, dateCreate: "12.12.2021", content: "Для бариста и посетителей кофеен специальные кружки для кофе — это ещё один способ проконтролировать вкус напитка и приготовить его именно так, как нравится вам. Теперь, кроме регулировки"),
        DetailItemModel(image: Constants.Image.testKogi, title: "Корги", isFavorite: true, dateCreate: "12.12.2021", content: "Для бариста и посетителей кофеен специальные кружки для кофе — это ещё один способ проконтролировать вкус напитка и приготовить его именно так, как нравится вам. Теперь, кроме регулировки"),
        DetailItemModel(image: Constants.Image.testKogi, title: "Корги", isFavorite: true, dateCreate: "12.12.2021", content: "Для бариста и посетителей кофеен специальные кружки для кофе — это ещё один способ проконтролировать вкус напитка и приготовить его именно так, как нравится вам. Теперь, кроме регулировки"),
        DetailItemModel(image: Constants.Image.testKogi, title: "Корги", isFavorite: true, dateCreate: "12.12.2021", content: "Для бариста и посетителей кофеен специальные кружки для кофе — это ещё один способ проконтролировать вкус напитка и приготовить его именно так, как нравится вам. Теперь, кроме регулировки")
        ]
    }
}


