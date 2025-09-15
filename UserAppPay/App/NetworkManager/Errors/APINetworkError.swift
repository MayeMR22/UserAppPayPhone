//
//  APINetworkError.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import Foundation

enum APINetworkError: Error {
    case invalidURL
    case badResponse(statusCode: Int)
    case invalidData
    case invalidRequest
    case noFound
    case decodingError(Error)
    case underlying(Error)
}

extension APINetworkError: LocalizedError {
    var errorDescription: String? {
        return NSLocalizedString(
            "En estos momentos la aplicación no está disponible, por favor ingresa más tarde.",
            comment: "apiError"
        )
    }
}
