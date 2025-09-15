//
//  User.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    let id: Int
    var name: String
    let username: String
    var email: String
    let address: Address?
    let phone: String?
    let website: String?
    let company: Company?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
}
