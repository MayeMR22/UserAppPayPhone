//
//  ServiceFactory.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import Foundation

class ServiceFactory: ServiceFactoryType {
    func createService<T: Decodable>(for endpoint: EndpointType) -> BaseService<T> {
        return BaseService<T>(endpoint: endpoint)
    }
}
