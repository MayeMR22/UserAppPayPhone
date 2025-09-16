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
            await viewModel.fetchUsers(forceRefresh: false)
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

