//
//  SignUpService.swift
//  DomainOAuthInterface
//
//  Created by Derrick kim on 7/9/24.
//

import Combine
import Foundation
import Core
import DomainOAuthInterface

extension SignUpService: SignUpServiceInterface {
    public func signUp(_ entity: UserSignUpEntity) -> AnyPublisher<SignUpResult, SignUpError> {
        let request = entity.toDTO()
        let endpoint = FeelinAPI<TokenResponse>.signUp(request: request)

        return networkProvider.request(endpoint)
            .tryMap { [jwtDecoder] response -> (AccessToken, RefreshToken) in
                return (
                    try jwtDecoder.decode(response.accessToken, as: AccessToken.self),
                    try jwtDecoder.decode(response.refreshToken, as: RefreshToken.self)
                )
            }
            .tryMap { [tokenStorage, tokenKeyHolder] (accessToken, refreshToken) in
                let accessTokenKey = try tokenKeyHolder.fetchAccessTokenKey()
                let refreshTokenKey = try tokenKeyHolder.fetchRefreshTokenKey()

                try tokenStorage.save(token: accessToken, for: accessTokenKey)
                try tokenStorage.save(token: refreshToken, for: refreshTokenKey)
            }
            .map { _ in
                return SignUpResult.success
            }
            .mapError({ error in
                switch error {
                case let error as KeychainError:
                    return SignUpError.keychainError(error)

                case let error as NetworkError:
                    return SignUpError.networkError(error)

                case let error as JWTError:
                    return SignUpError.jwtParsingError(error)

                default:
                    return SignUpError.unExpectedError
                }
            })
            .eraseToAnyPublisher()
    }
}