//
//  UsersCoordinatorView.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import SwiftUI

struct UsersCoordinatorView: View {
    @StateObject private var coordinator = BaseCoordinator()
    let userRepository: UsersRepositoryType

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            UsersView(viewModel: UsersViewModel(
                userRepository: userRepository,
                coordinator: coordinator
            ))
            .navigationDestination(for: User.self) { user in
                UserDetailView(viewModel: UserDetailViewModel(
                    user: user,
                    userRepository: userRepository,
                    coordinator: coordinator
                ))
            }
        }
        .sheet(item: $coordinator.sheetItem) { sheet in
            // TODO: - Feature add user
        }
    }
}
