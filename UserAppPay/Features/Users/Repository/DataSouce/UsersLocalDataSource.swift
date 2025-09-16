//
//  UsersLocalDataSource.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import RealmSwift

protocol UsersLocalDataSourceType {
    func getUsers() async throws -> [User]
    func save(users: [User]) async throws
    func updateUser(_ user: User) async throws
}

@MainActor
final class  UsersLocalDataSource: UsersLocalDataSourceType {
    private let realm: Realm
    
    init() {
        self.realm = try! Realm()
    }
    
    func getUsers() async throws -> [User] {
        let realmUsers = realm.objects(RealmUser.self)
        return realmUsers.map { $0.toUser() }
    }
    
    func save(users: [User]) async throws {
        let realmUsers = users.map { RealmUser.from(user: $0) }
        try realm.write {
            realm.add(realmUsers, update: .modified)
        }
    }
    
    func updateUser(_ user: User) async throws {
        guard let userToUpdate = realm.object(ofType: RealmUser.self, forPrimaryKey: user.id) else {
            return
        }
        
        try realm.write {
            userToUpdate.name = user.name
            userToUpdate.email = user.email
        }
    }
}
