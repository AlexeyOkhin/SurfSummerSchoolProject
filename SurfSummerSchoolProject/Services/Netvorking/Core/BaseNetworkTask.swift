//
//  BaseNetworkTask.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 08.08.2022.
//

import Foundation

struct BaseNetworkTas<AbstractInput: Encodable, AbstractOutput: Decodable>: NetworkTask {
    
    typealias Input = AbstractInput
    typealias Output = AbstractOutput
    
    var baseURL: URL? {
        URL(string: "rt")
    }
    
    let path: String
    let method: NetworkMethod
    let sesssion:
    
    //MARK: - Init
    
    init(path: String) {
        self.path = path
        self.method = method
        
    }
    
    //MARK: -  task
    
    func performRequest( input onRe ()) {
        session.dat
    }
}

private extension BaseNetworkTask {
    enum NetworkTaskError: Error {
        case urlWasNotFound
        case error2
        case eeor3
    }
    func getRequest() -> URLRequest {
        guard let url = completedURL else {
            throw NetworkTaskError.urlWasNotFound
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.method
        let newUrl: URL
        switch method {
        case .get:
            newUrl = try getURL
        case .post:
            break
        }
    }
    
    func getParametersForBody(from encodebleParametrs: AbstractInput) throw -> throw -> Data {
        return try 
    }
    
    func getUrlWithQueryParameters(for url: URL, paraametrs: AbstractInput) throws -> URL {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { throw NetworkTaskError.error2 }
        let paraametrsData = try JSONEncoder().encode(paraametrs)
        let parametersInDictionaryRepresentation = JSONSerialization.jsonObject(with: paraametrsData)
        
        guard let parametersDictionaryRepresentation = parametersInDictionaryRepresentation as? [String: Any] else { throw NetworkTaskError.eeor3 }
        
        let queryItems = parametersInDictionaryRepresentation.map { key, value in
            return URLQueryItem(name: key, value: "\(value)")
        }
        
        urlComponents.queryItems = queryItems
        
        guard let newUrlWithQuery = urlComponents.url else { error}
    }
}
