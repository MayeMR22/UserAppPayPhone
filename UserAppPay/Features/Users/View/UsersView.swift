//
//  UsersView.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import SwiftUI

struct UsersView: View {
    @StateObject var viewModel: UsersViewModel
    
    var body: some View {
        Group {
            if viewModel.isLoading && viewModel.users.isEmpty {
                ProgressView(NSLocalizedString("loading", comment: ""))
                
            } else if let errorMessage = viewModel.errorMessage {
                VStack(spacing: 10) {
                    Text("⚠️")
                        .font(.largeTitle)
                    Text(errorMessage)
                        .multilineTextAlignment(.center)
                    Button("Intentar de nuevo") {
                        Task { await viewModel.fetchUsers() }
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
                
            }  else {
                List {
                    ForEach(viewModel.users) { user in
                        UserRowView(user: user)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewModel.didTapUser(user)
                            }
                    }
                    .onDelete(perform: viewModel.deleteUser)
                }
                .refreshable {
                    await viewModel.fetchUsers()
                }
            }
        }
        .navigationTitle(NSLocalizedString("Usuarios", comment: ""))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: viewModel.didTapAddUser) {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear(perform: viewModel.onAppear)
    }
}

