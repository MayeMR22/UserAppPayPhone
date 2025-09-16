//
//  UsersFacade.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

protocol UsersRepositoryType {
    func getUsers(forceRefresh: Bool) async throws -> [User]
    func save(users: [User]) async throws
    func updateUser(_ user: User) async throws
}

final class UsersRepository: UsersRepositoryType {
    private let remoteData: UsersRemoteDataSourceType
    private let localData: UsersLocalDataSourceType
    
    init(remoteData: UsersRemoteDataSourceType, localData: UsersLocalDataSourceType) {
        self.remoteData = remoteData
        self.localData = localData
    }
    
    func getUsers(forceRefresh: Bool = false) async throws -> [User] {
        if forceRefresh {
            return try await fetchAndStoreRemoteUsers()
        }
        
        let localUsers = try await localData.getUsers()
        
        if !localUsers.isEmpty {
            return localUsers
        }
        
        return try await fetchAndStoreRemoteUsers()
    }
    
    private func fetchAndStoreRemoteUsers() async throws -> [User] {
        let remoteUsers = try await remoteData.getUsers()
        try await localData.save(users: remoteUsers)
        return remoteUsers
    }
    
    func save(users: [User]) async throws {
        try await localData.save(users: users)
    }
    
    func updateUser(_ user: User) async throws {
        try await localData.updateUser(user)
    }
}
