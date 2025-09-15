//
//  UserRowView.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import SwiftUI

struct UserRowView: View {
    let user: User

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(user.name)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("@\(user.username)")
                .font(.subheadline)
                .foregroundColor(.blue)
            
            Text(user.email)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(user.phone ?? "N/A")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Label(user.address?.city ?? "N/A", systemImage: "mappin.and.ellipse")
                .font(.caption)
                .foregroundColor(.secondary)
                .italic()
        }
        .padding(.vertical, 6)
    }
}
