//
//  TokenContainer.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 08.08.2022.
//

import Foundation

import Foundation

struct TokenContainer {

    let token: String
    let receivingDate: Date
    
    var tokenExpiringTime: TimeInterval {
        39600
    }
    
    var isExpired: Bool {
        let now = Date()
        if receivingDate.addingTimeInterval(tokenExpiringTime) > now {
            return false
        } else {
            return true
        }
    }
}
