//
//  ServiceContract.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import Foundation
import Alamofire

protocol ServiceContractType {
    associatedtype ResponseType: Decodable
    func execute() async throws -> ResponseType
}

protocol NetworkClientType {
    func request<T: Decodable>(_ endpoint: EndpointType, responseType: T.Type) async throws -> T
}

protocol ServiceFactoryType {
    func createService<T: Decodable>(for endpoint: EndpointType) -> BaseService<T>
}

enum HTTPMethod: String {
    case GET, POST
}

protocol EndpointType {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}
