//
//  CreateUserViewModel.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import Foundation

@MainActor
final class CreateUserViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var phone = ""
    @Published var nameError: String?
    @Published var emailError: String?
    @Published var phoneError: String?
    
    private let userRepository: UsersRepositoryType
    private let coordinator: BaseCoordinator
    
    init(userRepository: UsersRepositoryType, coordinator: BaseCoordinator) {
        self.userRepository = userRepository
        self.coordinator = coordinator
    }
    
    func saveUser() {
        guard validateFields() else { return }
        
        Task {
            do {
                _ = try await userRepository.addUser(name: name, email: email, phone: phone)
                coordinator.sheetItem = nil
                
            } catch {
                throw APINetworkError.invalidData
            }
        }
    }
    
    private func validateFields() -> Bool {
        nameError = nil
        emailError = nil
        phoneError = nil
        
        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            nameError = "El nombre es obligatorio."
        }
        
        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            emailError = "El email es obligatorio."
        } else if !isValidEmail(email) {
            emailError = "El formato del email no es válido."
        }
        
        if phone.trimmingCharacters(in: .whitespaces).isEmpty {
            phoneError = "El teléfono es obligatorio."
        }
        
        return nameError == nil && emailError == nil && phoneError == nil
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
