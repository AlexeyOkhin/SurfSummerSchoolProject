//
//  DetailItemModel.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 07.08.2022.
//

import UIKit

struct DetailItemModel {
    let image: UIImage?
    let title: String
    var isFavorite: Bool
    let dateCreate: String
    let content: String
    
    static func createDefoult() -> DetailItemModel {
        .init(image: Constants.Image.testKogi, title: "Корги", isFavorite: false, dateCreate: "12.12.2021", content: "Для бариста и посетителей кофеен специальные кружки для кофе — это ещё один способ проконтролировать вкус напитка и приготовить его именно так, как нравится вам. Теперь, кроме регулировки")
    }
}
