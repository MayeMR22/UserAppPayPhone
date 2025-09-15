//
//  UserRepository.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import Foundation

protocol UsersRepositoryType {
    func getUsers() async throws -> [User]
}

final class UsersRepository: UsersRepositoryType {
    private let serviceFactory: ServiceFactory
    
    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
    
    func getUsers() async throws -> [User] {
        let service: BaseService<[User]> = serviceFactory.createService(for: UsersEndpoint())
        return try await service.execute()
    }
}
