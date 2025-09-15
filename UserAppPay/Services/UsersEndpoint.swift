//
//  UsersEndpoint.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import Foundation

struct UsersEndpoint: EndpointType {
    var baseURL: String { UserPayConstans.Host.apiUrl }
    var path: String { UserPayConstans.Host.userList }
    var method: HTTPMethod { .GET }
    var headers: [String: String]? { nil }
    var body: Data? { nil }
}
