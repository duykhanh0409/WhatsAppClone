//
//  AuthScreenModel.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 25/1/25.
//

import Foundation

@MainActor
final class AuthScreenModel: ObservableObject {
    
    // MARK: Published Properties

    @Published var isLoading = false
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    @Published var errorState : (showError: Bool, errorMessage: String) = (false, "Uh Oh")
    
    // MARK: Computed Properties
    var disableLoginButton: Bool {
        return email.isEmpty || password.isEmpty || isLoading
    }
    
    var disableSignUpButton: Bool {
        return email.isEmpty || password.isEmpty || username.isEmpty || isLoading
    }
    
    func handleSignUp() async {
        isLoading = true
        
        do {
            try await AuthManager.shared.createdAccount(for: username, with: email, and: password)
        }catch {
            isLoading = false
            errorState = (true, error.localizedDescription)
        }
    }
    
    func handleLogined() async {
        isLoading = true
        
        do {
            try await AuthManager.shared.login(with: email, and: password)
        }catch {
            isLoading = false
            errorState = (true, "Failed to login \(error.localizedDescription)")
        }
    }
}

