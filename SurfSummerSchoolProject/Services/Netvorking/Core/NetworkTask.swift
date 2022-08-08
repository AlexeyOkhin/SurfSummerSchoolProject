//
//  NetworkTask.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 08.08.2022.
//

import Foundation

protocol NetworkTask {
    
    associatedtype Input: Encodable
    associatedtype Output: Decodable
    
    var baseURL: URL? { get }
    var path: String { get }
    var completedURL: URL? { get }
    var method: NetworkMethod { get }
    
    func performRequest(
        input: Input,
        _ onResponseReceived: (_ Result<Output, Error>)) -> Void
    )
}

//enum OurResult<Output, Error: Swift.Error> {
//    case successful(_ output: Output)
//    case failure(_ failure: Error)
//}

extension NetworkTask {
    var completedURL: URL? {
        baseURL?.appendingPathComponent(path)
    }
}
