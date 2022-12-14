//
//  BaseNetworkTask.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 08.08.2022.
//

import Foundation

struct BaseNetworkTask<AbstractInput: Encodable, AbstractOutput: Decodable>: NetworkTask {

    // MARK: - NetworkTask

    typealias Input = AbstractInput
    typealias Output = AbstractOutput

    var baseURL: URL? {
        URL(string: "https://pictures.chronicker.fun/api")
    }

    let path: String
    let method: NetworkMethod
    let session: URLSession = URLSession(configuration: .default)
    let isNeedInjectToken: Bool
    var urlCache: URLCache {
        URLCache.shared
    }

    var tokenStorage: TokenStorage {
        BaseTokenStorage()
    }

    // MARK: - Initializtion

    init(inNeedInjectToken: Bool, method: NetworkMethod, path: String) {
        self.isNeedInjectToken = inNeedInjectToken
        self.path = path
        self.method = method
    }

    // MARK: - NetworkTask

    func performRequest(
        input: AbstractInput,
        _ onResponseWasReceived: @escaping (_ result: Result<AbstractOutput, Error>) -> Void
    ) {
        do {
            let request = try getRequest(with: input)
            
            if let cachedResponse = getCacheResponseFromCache(by: request) {
                
                let mappedModel = try JSONDecoder().decode(AbstractOutput.self, from: cachedResponse.data)
                onResponseWasReceived(.success(mappedModel))
                
                return
            }
            session.dataTask(with: request) { data, response, error in
                if let error = error {
                    onResponseWasReceived(.failure(error))
                } else if let data = data {
                    do {
                        let mappedModel = try JSONDecoder().decode(AbstractOutput.self, from: data)
                        saveResponseToCache(response, cacheData: data, by: request)
                        onResponseWasReceived(.success(mappedModel))
                    } catch {
                        onResponseWasReceived(.failure(error))
                    }
                } else {
                    onResponseWasReceived(.failure(NetworkTaskError.unknownError))
                }
            }
            .resume()
        } catch {
            onResponseWasReceived(.failure(error))
        }
    }

}

// MARK: - EmptyModel

extension BaseNetworkTask where Input == EmptyModel {

    func performRequest(_ onResponseWasReceived: @escaping (_ result: Result<AbstractOutput, Error>) -> Void) {
        performRequest(input: EmptyModel(), onResponseWasReceived)
    }

}

//MARK: - For Logout

extension BaseNetworkTask {
    func performRequestWithoutResponse(
        input: AbstractInput,
        _ onResponseWasReceived: @escaping (_ result: Result<String, Error>) -> Void) {
            do {
                let request = try getRequest(with: input)
                session.dataTask(with: request) { data, response, error in
                    if let error = error {
                        onResponseWasReceived(.failure(error))
                    } else if let response = response {
                        if let httpResponse = response as? HTTPURLResponse {
                            switch httpResponse.statusCode {
                            case 204:
                                let success = "The logout is completed"
                                onResponseWasReceived(.success(success))
                            case 401: onResponseWasReceived(.failure(NetworkTaskError.exitFailed))
                            default: onResponseWasReceived(.failure(NetworkTaskError.unknownError))
                            }
                        }
                    } else {
                        onResponseWasReceived(.failure(NetworkTaskError.unknownError))
                    }
                }
                .resume()
            } catch {
                onResponseWasReceived(.failure(NetworkTaskError.unknownError))
            }
        }
}

//MARK: - For cleare cache for develop

extension BaseNetworkTask {
    
    func cleareCache() {
        urlCache.removeAllCachedResponses()
    }
}

//MARK: - Cache logic

private extension BaseNetworkTask {
    
    func getCacheResponseFromCache(by request: URLRequest) -> CachedURLResponse? {
        urlCache.cachedResponse(for: request)
    }
    
    func saveResponseToCache(_ response: URLResponse?, cacheData: Data?, by request: URLRequest) {
        guard let response = response, let cacheData = cacheData else {
            return
        }
        
        let cachebleUrlResponse = CachedURLResponse(response: response, data: cacheData)
        urlCache.storeCachedResponse(cachebleUrlResponse, for: request)
    }
    
}
// MARK: - Private Methods

private extension BaseNetworkTask {

    enum NetworkTaskError: Error {
        case unknownError
        case urlWasNotFound
        case urlComponentWasNotCreated
        case parametersIsNotValidJsonObject
        case exitFailed
    }

    func getRequest(with parameters: AbstractInput) throws -> URLRequest {
        guard let url = completedURL else {
            throw NetworkTaskError.urlWasNotFound
        }

        var request: URLRequest
        switch method {
        case .get:
            let newUrl = try getUrlWithQueryParameters(for: url, parameters: parameters)
            request = URLRequest(url: newUrl)
        case .post:
            request = URLRequest(url: url)
            request.httpBody = try getParametersForBody(from: parameters)
        }
        request.httpMethod = method.method

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if isNeedInjectToken {
            request.addValue("Token \(try tokenStorage.getToken().token)", forHTTPHeaderField: "Authorization")
        }

        return request
    }

    func getParametersForBody(from encodableParameters: AbstractInput) throws -> Data {
        return try JSONEncoder().encode(encodableParameters)
    }

    func getUrlWithQueryParameters(for url: URL, parameters: AbstractInput) throws -> URL {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw NetworkTaskError.urlComponentWasNotCreated
        }

        let parametersInDataRepresentation = try JSONEncoder().encode(parameters)
        let parametersInDictionaryRepresentation = try JSONSerialization.jsonObject(with: parametersInDataRepresentation)

        guard let parametersInDictionaryRepresentation = parametersInDictionaryRepresentation as? [String: Any] else {
            throw NetworkTaskError.parametersIsNotValidJsonObject
        }

        let queryItems = parametersInDictionaryRepresentation.map { key, value in
            return URLQueryItem(name: key, value: "\(value)")
        }

        if !queryItems.isEmpty {
            urlComponents.queryItems = queryItems
        }

        guard let newUrlWithQuery = urlComponents.url else {
            throw NetworkTaskError.urlWasNotFound
        }

        return newUrlWithQuery
    }

}
