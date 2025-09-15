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
                        viewModel.saveChanges()
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

//struct UserDetailView: View {
//    
//    // El ViewModel se recibe como un @StateObject para que la vista
//    // se suscriba a sus cambios y se redibuje cuando sea necesario.
//    @StateObject private var viewModel: UserDetailViewModel
//    
//    init(viewModel: UserDetailViewModel) {
//        _viewModel = StateObject(wrappedValue: viewModel)
//    }
//    
//    var body: some View {
//        Form {
//            // --- SECCIÓN DE PERFIL ---
//            Section {
//                HStack {
//                    Spacer()
//                    VStack(spacing: 16) {
//                        // Imagen de perfil por default usando SF Symbols.
//                        Image(systemName: "person.circle.fill")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 100, height: 100)
//                            .foregroundColor(.gray.opacity(0.5))
//                        
//                        Text(viewModel.getUser().username)
//                            .font(.title2)
//                            .bold()
//                    }
//                    Spacer()
//                }
//                .padding(.vertical)
//            }
//            
//            // --- SECCIÓN DE EDICIÓN ---
//            Section(header: Text("Información Editable")) {
//                HStack {
//                    Text("Nombre:").bold().frame(width: 80, alignment: .leading)
//                    // TextField enlazado a la propiedad 'name' del ViewModel.
//                    TextField("Nombre completo", text: $viewModel.name)
//                }
//                HStack {
//                    Text("Email:").bold().frame(width: 80, alignment: .leading)
//                    // TextField enlazado a la propiedad 'email' del ViewModel.
//                    TextField("Correo electrónico", text: $viewModel.email)
//                        .keyboardType(.emailAddress)
//                        .autocapitalization(.none)
//                }
//            }
//            
//        
//        }
//        .navigationTitle("Detalle del Usuario")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            // Botón en la barra de navegación para guardar los cambios.
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button("Guardar") {
//                    viewModel.saveChanges()
//                }
//            }
//        }
//        // Alerta que se muestra cuando showingSaveConfirmation en el ViewModel es true.
//        .alert("Guardado", isPresented: $viewModel.showingSaveConfirmation) {
//            Button("OK", role: .cancel) { }
//        } message: {
//            Text("Los cambios se han guardado localmente.")
//        }
//    }
//}
//
//// Pequeña vista auxiliar para las filas de información no editables.
//struct InfoRowDetail: View {
//    let label: String
//    let value: String
//    
//    var body: some View {
//        HStack {
//            Text(label + ":").bold()
//            Text(value)
//            Spacer()
//        }
//    }
//}
