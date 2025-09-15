//
//  UserListViewModel.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import Combine
import Foundation

@MainActor
final class UsersViewModel: ObservableObject {
    @Published private(set) var users: [User] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?
    
    private let userRepository: UsersRepositoryType
    private let coordinator: BaseCoordinator
    
    init(userRepository: UsersRepositoryType, coordinator: BaseCoordinator) {
        self.userRepository = userRepository
        self.coordinator = coordinator
    }
    
    func onAppear() {
        guard users.isEmpty else { return }

        Task {
            await fetchUsers()
        }
    }
    
    func fetchUsers() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedUsers = try await userRepository.getUsers()
            self.users = fetchedUsers.sorted { $0.id > $1.id }
        } catch {
            self.errorMessage = error.localizedDescription
            print("Error fetching users: \(error)")
        }
        
        isLoading = false
    }
    
    func deleteUser(at offsets: IndexSet) {
        // TODO: - Feature delete user
    }
    
    func didTapUser(_ user: User) {
        coordinator.showUserDetails(user)
    }

    func didTapAddUser() {
        coordinator.showCreateUserSheet()
    }
}
