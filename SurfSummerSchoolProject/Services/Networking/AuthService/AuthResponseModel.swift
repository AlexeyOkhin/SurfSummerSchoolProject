//
//  AuthResponseModel.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 08.08.2022.
//

import Foundation

struct AuthResponseModel: Decodable {

    let token: String
    let user_info: UserInfo
}

struct UserInfo: Codable {
    
    let id: String
    let phone: String
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String
    let city: String
    let about: String
}
