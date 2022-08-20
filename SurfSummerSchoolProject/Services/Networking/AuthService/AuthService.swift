//
//  AuthService.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 08.08.2022.
//

import Foundation

struct AuthService {
    
    let dataTask = BaseNetworkTask<AuthRequestModel, AuthResponseModel>(
        inNeedInjectToken: false,
        method: .post,
        path: "auth/login"
    )
    
    let dataTaskLogout = BaseNetworkTask<EmptyModel, EmptyModel> (
        inNeedInjectToken: true,
        method: .post,
        path: "auth/logout"
    )

    func performLoginRequestAndSaveToken(
        credentials: AuthRequestModel,
        _ onResponseWasReceived: @escaping (_ result: Result<AuthResponseModel, Error>) -> Void
    ) {
        dataTask.performRequest(input: credentials) { result in
            if case let .success(responseModel) = result {
                do {
                    try dataTask.tokenStorage.set(newToken: TokenContainer(token: responseModel.token, receivingDate: .now))
                    try UserInfoStorage().writeUserInfoIntoStorage(userInfo: responseModel.user_info)
                } catch {
                    // TODO: - Handle error if token not was received from server
                }
            }
            onResponseWasReceived(result)
        }
    }
    
    func performLogoutRequestWithResetData(
        credentials: EmptyModel,
        _ onResponseWasReceived: @escaping (_ result: Result<String, Error>) -> Void
    ) {
        dataTaskLogout.performRequestWithoutResponse(input: EmptyModel()) { result in
            if case .success(_) = result {
                do {
                    try dataTaskLogout.tokenStorage.removeTokenFromConteiner()
                    onResponseWasReceived(result)
                    dataTaskLogout.cleareCache()
                } catch {
                    print(error)
                }
            }
        }
    }
}
