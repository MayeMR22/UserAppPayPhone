//
//  UserAppPayApp.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import SwiftUI

@main
struct UserAppPayApp: App {
    private let userRepository: UsersRepositoryType
    
    init() {
        let serviceFactory = ServiceFactory()
        let remoteSource = UsersRemoteDataSource(serviceFactory: serviceFactory)
        let localSource = UsersLocalDataSource()
        self.userRepository = UsersRepository(remoteData: remoteSource, localData: localSource)
    }
    
    var body: some Scene {
        WindowGroup {
            UsersCoordinatorView(userRepository: userRepository)
        }
    }
}
