//
//  BaseService.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import Foundation

class BaseService<T: Decodable>: ServiceContractType {
    private let endpoint: EndpointType
    private let client: NetworkClientType
    
    init(endpoint: EndpointType, client: NetworkClientType = AlamofireNetworkClient()) {
        self.endpoint = endpoint
        self.client = client
    }

    func execute() async throws -> T {
        do {
            return try await client.request(endpoint, responseType: T.self)
        } catch let error as DecodingError {
            throw APINetworkError.decodingError(error)
        } catch {
            throw error
        }
    }
}
