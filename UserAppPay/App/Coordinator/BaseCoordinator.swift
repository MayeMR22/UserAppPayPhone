//
//  BaseCoordinator.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import SwiftUI

@MainActor
class BaseCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var sheetItem: Sheet? = nil

    enum Sheet: Identifiable {
        case createUser
        var id: String { "createUserSheet" }
    }
    
    func showUserDetails(_ user: User) {
        path.append(user)
    }
    
    func showCreateUserSheet() {
        sheetItem = .createUser
    }
    
    func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}
