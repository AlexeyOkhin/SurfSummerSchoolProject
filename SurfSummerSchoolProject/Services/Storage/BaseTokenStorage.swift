//
//  BaseTokenStorage.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 08.08.2022.
//

import Foundation

import Foundation

struct BaseTokenStorage: TokenStorage {

    func getToken() throws -> TokenContainer {
        TokenContainer(
            token: "e72d81999f9cf59d3bea6099c0b0dd72c5e99c8e6415a43ac2b8401069303430"
        )
    }

    func set(newToken: TokenContainer) throws { }

}
