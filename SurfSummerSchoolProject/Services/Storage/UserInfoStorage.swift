//
//  UserInfoStorage.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 18.08.2022.
//

import Foundation

struct UserInfoStorage {
    
    //MARK: - Private Properties
    
    private let storage: UserDefaults
    private let userInfoKeyInStorage = "UserInfo"
    
    //MARK: - Internal Methods
    
    func writeUserInfoIntoStorage(userInfo: UserInfo) {
        //guard let encodeData = try? JSONEncoder().encode(UserInfo) else { return }
        //storage.set(encodeData, forKey: userInfoKeyInStorage)
    }
}
