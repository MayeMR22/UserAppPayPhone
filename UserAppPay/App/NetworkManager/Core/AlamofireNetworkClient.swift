//
//  AlamofireNetworkClient.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import Foundation
import Alamofire

final class AlamofireNetworkClient: NetworkClientType {
    func request<T: Decodable>(_ endpoint: EndpointType, responseType: T.Type) async throws -> T {
        let urlString = endpoint.baseURL + endpoint.path
        guard let _ = URL(string: urlString) else {
            throw APINetworkError.invalidURL
        }
        
        let afMethod: Alamofire.HTTPMethod = endpoint.method == .GET ? .get : .post
        let headers = HTTPHeaders(endpoint.headers ?? [:])
        let parameters: Any? = {
            if let body = endpoint.body {
                return try? JSONSerialization.jsonObject(with: body, options: [])
            }
            return nil
        }()
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(urlString,
                       method: afMethod,
                       parameters: parameters as? [String: Any],
                       encoding: endpoint.method == .GET ? URLEncoding.default : JSONEncoding.default,
                       headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    if let code = response.response?.statusCode, code == 404 {
                        continuation.resume(throwing: APINetworkError.noFound)
                    } else if let code = response.response?.statusCode {
                        continuation.resume(throwing: APINetworkError.badResponse(statusCode: code))
                    } else {
                        continuation.resume(throwing: APINetworkError.underlying(error))
                    }
                }
            }
        }
    }
}
