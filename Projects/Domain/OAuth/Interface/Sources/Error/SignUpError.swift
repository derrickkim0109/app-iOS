//
//  SignUpError.swift
//  DomainOAuthInterface
//
//  Created by Derrick kim on 7/9/24.
//

import Core
import Foundation

public enum SignUpError: LocalizedError, Equatable {
    public static func == (lhs: SignUpError, rhs: SignUpError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }

    case keychainError(KeychainError)
    case networkError(NetworkError)
    case jwtParsingError(JWTError)
    case unExpectedError
}