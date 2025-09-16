//
//  UserDetailViewModel.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import Foundation
import Combine

@MainActor
class UserDetailViewModel: ObservableObject {
    @Published var user: User
    @Published var isEditing = false
    @Published var name: String
    @Published var email: String
    
    private let userRepository: UsersRepositoryType
    private let coordinator: BaseCoordinator
    private var cancellables = Set<AnyCancellable>()
    
    init(user: User, userRepository: UsersRepositoryType, coordinator: BaseCoordinator) {
        self.user = user
        self.userRepository = userRepository
        self.coordinator = coordinator
        self.name = user.name
        self.email = user.email
    }
    
    func toggleEdit() {
        if isEditing {
            name = user.name
            email = user.email
        }
        isEditing.toggle()
    }
    
    func saveChanges() async throws {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        var updatedUser = user
        updatedUser.name = name
        updatedUser.email = email
        
        do {
            try await userRepository.updateUser(updatedUser)
            
            self.user = updatedUser
            self.isEditing = false
            
        } catch {
            throw APINetworkError.invalidData
        }
    }
}
