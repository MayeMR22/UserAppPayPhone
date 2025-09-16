//
//  CreateUserView.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import SwiftUI

struct CreateUserView: View {
    @StateObject var viewModel: CreateUserViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Datos del Nuevo Usuario")) {
                    VStack(alignment: .leading) {
                        TextField("Nombre completo", text: $viewModel.name)
                        if let error = viewModel.nameError {
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                    VStack(alignment: .leading) {
                        TextField("Correo electrónico", text: $viewModel.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        if let error = viewModel.emailError {
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                    VStack(alignment: .leading) {
                        TextField("Teléfono", text: $viewModel.phone)
                            .keyboardType(.phonePad)
                        
                        if let error = viewModel.phoneError {
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Crear Usuario")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        viewModel.saveUser()
                    }
                }
            }
        }
    }
}
