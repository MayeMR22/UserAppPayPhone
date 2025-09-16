//
//  UserLocation.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import Foundation

struct UserLocation: Codable, Equatable, Hashable {
    let latitud: String?
    let longitud: String?
    
    enum CodingKeys: String, CodingKey {
        case latitud = "lat"
        case longitud = "lng"
    }
}
