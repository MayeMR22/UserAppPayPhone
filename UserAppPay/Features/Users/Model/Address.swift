//
//  Address.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import Foundation

struct Address: Codable, Equatable, Hashable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let location: UserLocation?
    
    enum CodingKeys: String, CodingKey {
        case street, suite, city, zipcode
        case location = "geo"
    }
}
