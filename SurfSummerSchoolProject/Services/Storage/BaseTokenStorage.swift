//
//  BaseTokenStorage.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 08.08.2022.
//

import Foundation

import Foundation

struct BaseTokenStorage: TokenStorage {
    
    //MARK: - Nested Types
    
    private enum Constants {
        static let applicationNameInKeyChain = "com.surf.education.project"
        static let tokenKey = "token"
        static let tokenDateKey = "tokenDate"
    }
    //MARK: - Private Properties
    
    private var unprotectedStorage: UserDefaults {
        UserDefaults.standard
    }
    
    //MARK: - TokenStorage

    func getToken() throws -> TokenContainer {
            
            let queryDictionaryForSavingToken: [CFString: AnyObject] = [
                kSecAttrService: Constants.applicationNameInKeyChain as AnyObject,
                kSecAttrAccount: Constants.tokenKey as AnyObject,
                kSecClass: kSecClassGenericPassword,
                kSecMatchLimit: kSecMatchLimitOne,
                kSecReturnData: kCFBooleanTrue
            ]
            
            var tokenInResult: AnyObject?
            let status = SecItemCopyMatching(queryDictionaryForSavingToken as CFDictionary, &tokenInResult)
            
            guard let data = tokenInResult as? Data else {
                throw Error.tokenWasNotFoundInKeyChainOrCantRepresentData
            }
        
            let retrivingToken = try JSONDecoder().decode(String.self, from: data)
            let tokenSavingDate = try getSavingTokenDate()
             
            return TokenContainer(token: retrivingToken, receivingDate: tokenSavingDate)
    }

    func set(newToken: TokenContainer) throws {
        try removeTokenFromConteiner()
        let tokenData = try? JSONEncoder().encode(newToken.token)
        let queryDictionaryForSavingToken: [CFString: AnyObject] = [
            kSecAttrService: Constants.applicationNameInKeyChain as AnyObject,
            kSecAttrAccount: Constants.tokenKey as AnyObject,
            kSecClass: kSecClassGenericPassword,
            kSecValueData: tokenData as AnyObject
        ]
        
        let status = SecItemAdd(queryDictionaryForSavingToken as CFDictionary, nil)
        
        try throwErrorFromStatusIfNeeded(status)
        
        saveTokenSavingDate(.now)
    }
    
    func removeTokenFromConteiner() throws {
        let queryDictionaryForDeleteToken: [CFString: AnyObject] = [
            kSecAttrService: Constants.applicationNameInKeyChain as AnyObject,
            kSecAttrAccount: Constants.tokenKey as AnyObject,
            kSecClass: kSecClassGenericPassword
        ]
        
        let status = SecItemDelete(queryDictionaryForDeleteToken as CFDictionary)
        
        try throwErrorFromStatusIfNeeded(status)
    }

}
    //MARK: - Private Methods

private extension BaseTokenStorage {
    
    enum Error: Swift.Error {
        case unknownError(status: OSStatus)
        case keyIsAlreadyInKeyChain
        case tokenWasNotFoundInKeyChainOrCantRepresentData
        case tokenDateWasNotFound
    }
    
    func getSavingTokenDate() throws -> Date {
        guard let savingDate = unprotectedStorage.value(forKey: Constants.tokenDateKey) as? Date else {
            throw Error.tokenDateWasNotFound
        }
        return savingDate
    }
    
    func saveTokenSavingDate(_ newDate: Date) {
        unprotectedStorage.set(newDate, forKey: Constants.tokenDateKey)
    }
    
    func removeTokenSavingDate() {
        unprotectedStorage.set(nil, forKey: Constants.tokenDateKey)
    }
    
    func throwErrorFromStatusIfNeeded(_ status: OSStatus) throws {
        guard status == errSecSuccess else {
            throw Error.unknownError(status: status)
        }
        guard status != -25299 else {
            throw Error.keyIsAlreadyInKeyChain
        }
    }
}
