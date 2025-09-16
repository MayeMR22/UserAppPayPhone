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
    private var cancellables = Set<AnyCancellable>()

    
    private let userRepository: UsersRepositoryType
    private let coordinator: BaseCoordinator
    
    init(userRepository: UsersRepositoryType, coordinator: BaseCoordinator) {
        self.userRepository = userRepository
        self.coordinator = coordinator
        suscribeRefresh()
    }
    
    func onAppear() {
        Task {
            await fetchUsers(forceRefresh: false)
        }
    }
    
    func fetchUsers(forceRefresh: Bool) async {
           isLoading = true
           errorMessage = nil
           do {
               self.users = try await userRepository.getUsers(forceRefresh: forceRefresh)
           } catch {
               self.errorMessage = error.localizedDescription
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
    
    private func suscribeRefresh() {
        coordinator.refreshUserList
            .sink { [weak self] in
                Task {
                    await self?.fetchUsers(forceRefresh: false)
                }
            }
            .store(in: &cancellables)
    }
}
