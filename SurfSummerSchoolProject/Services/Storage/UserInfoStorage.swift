//
//  UserInfoStorage.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 18.08.2022.
//

import Foundation

struct UserInfoStorage {
    
    //MARK: - Nested Types
    
    private enum Error: Swift.Error {
        case storagePlistWasNotFound
    }
    
    //MARK: - Private Properties
    
    private let storage: UserDefaults
    private let userInfoKeyInStorage = "userInfo"
    
    //MARK: -  Initialization
    
    init() throws {
        guard let storage = UserDefaults(suiteName: "com.userInfo.info") else {
            throw Error.storagePlistWasNotFound
        }
        self.storage = storage
    }
    
    //MARK: - Internal Methods
    
    func writeUserInfoIntoStorage(userInfo: UserInfo) {
        guard let encodeData = try? PropertyListEncoder().encode(userInfo) else { return }
        storage.set(encodeData, forKey: userInfoKeyInStorage)
    }
    
    func getUserInfo() -> UserInfo? {
        guard let data = storage.value(forKey: userInfoKeyInStorage) as? Data,
              let infoItem = try? PropertyListDecoder().decode(UserInfo.self, from: data)
        else {
            return nil
        }
        return infoItem
    }
}
