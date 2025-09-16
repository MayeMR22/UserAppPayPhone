//
//  RealmUser.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import Foundation
import RealmSwift

final class RealmUser: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var username: String
    @Persisted var email: String
    @Persisted var phone: String?
    @Persisted var website: String?
    @Persisted var city: String?
    @Persisted var companyName: String?
    @Persisted var isLocallyCreated = false
    
    static func from(user: User) -> RealmUser {
        let realmUser = RealmUser()
        realmUser.id = user.id
        realmUser.name = user.name
        realmUser.username = user.username
        realmUser.email = user.email
        realmUser.phone = user.phone
        realmUser.website = user.website
        realmUser.city = user.address?.city
        realmUser.companyName = user.company?.name
        
        return realmUser
    }
    
    func toUser() -> User {
        var address: Address?
        if let city = self.city {
            address = Address(street: "", suite: "", city: city, zipcode: "", location: nil)
        }
        
        var company: Company?
        if let companyName = self.companyName {
            company = Company(name: companyName, catchPhrase: "", bs: nil)
        }
        
        return User(
            id: id,
            name: name,
            username: username,
            email: email,
            address: address,
            phone: phone,
            website: website,
            company: company 
        )
    }
}
