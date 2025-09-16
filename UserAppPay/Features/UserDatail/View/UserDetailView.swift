//
//  UserDetailView.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import SwiftUI

struct UserDetailView: View {
    @StateObject var viewModel: UserDetailViewModel
    
    var body: some View {
        Form {
            Section {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                if viewModel.isEditing {
                    VStack(alignment: .leading) {
                        Text("Nombre Completo").font(.caption).foregroundColor(.secondary)
                        TextField("Nombre", text: $viewModel.name)
                    }
                    VStack(alignment: .leading) {
                        Text("Email").font(.caption).foregroundColor(.secondary)
                        TextField("Email", text: $viewModel.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                } else {
                    InfoRow(label: "Nombre Completo", value: viewModel.user.name)
                    InfoRow(label: "Email", value: viewModel.user.email)
                }
                
                InfoRow(label: "Username", value: viewModel.user.username)
            }
            
            Section(header: Text("Información de Contacto")) {
                InfoRow(label: "Teléfono", value: viewModel.user.phone ?? "N/A")
                InfoRow(label: "Sitio Web", value: viewModel.user.website ?? "N/A")
            }
            
            Section(header: Text("Dirección")) {
                InfoRow(label: "Ciudad", value: viewModel.user.address?.city ?? "N/A")
                InfoRow(label: "Calle", value: viewModel.user.address?.street ?? "N/A")
                InfoRow(label: "Apartamento", value: viewModel.user.address?.suite ?? "N/A")
                InfoRow(label: "Código Postal", value: viewModel.user.address?.zipcode ?? "N/A")
            }
            
            Section(header: Text("Compañía")) {
                InfoRow(label: "Nombre", value: viewModel.user.company?.name ?? "N/A")
            }
        }
        .navigationTitle("Detalle del Usuario")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(viewModel.isEditing ? "Guardar" : "Editar") {
                    if viewModel.isEditing {
                        Task {
                            await viewModel.saveChanges()
                        }
                    } else {
                        viewModel.toggleEdit()
                    }
                }
            }
            if viewModel.isEditing {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar", role: .cancel, action: viewModel.toggleEdit)
                }
            }
        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    var isItalic: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .italic(isItalic)
        }
        .padding(.vertical, 2)
    }
}
