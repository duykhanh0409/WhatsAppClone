//
//  RootScreenModel.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 26/1/25.
//

import Foundation
import Combine

final class RootScreenModel: ObservableObject {
    @Published private(set) var authState = AuthState.pending
    private var cancellables: AnyCancellable?
    
    init() {
        cancellables = AuthManager.shared.authState.receive(on: DispatchQueue.main)
            .sink { [weak self] latestAuthState in
                self?.authState = latestAuthState
            }
            
//        AuthManager.testAccounts.forEach { email in
//            registerTestAccount(with: email)
//        }
    }
    
//    private func registerTestAccount(with email: String) {
//        Task {
//            let username = email.replacingOccurrences(of: "@test.com", with: "")
//            try? await AuthManager.shared.createdAccount(for: username, with: email, and: "12345678")
//        }
//    }
}
