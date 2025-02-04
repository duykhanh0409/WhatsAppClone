//
//  AuthProvider.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 25/1/25.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase

enum AuthState {
    case pending, loggedIn(UserItem), loggeOut
}

protocol AuthProvider {
    static var shared: AuthProvider { get }
    
    var authState: CurrentValueSubject<AuthState, Never> { get }
    func autoLogin()
    func login(with email:String, and password: String) async throws
    func createdAccount(for username: String, with email: String, and password: String) async throws
    func logout() async throws
}

enum AuthError: Error {
    case accountCreationFailed(_ description: String)
    case failedToSaveUserInfo(_ description: String)
    case emailLoginFailed(_ description: String)
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .accountCreationFailed(let description):
            return description
        case .failedToSaveUserInfo(let description):
            return description
        case .emailLoginFailed(let description):
            return description 
        }
    }
}

final class AuthManager: AuthProvider {
    
    private init() {
        Task {
            autoLogin()
        }
    }
    
    static let shared: AuthProvider = AuthManager()
    
    var authState =  CurrentValueSubject<AuthState, Never>(.pending)
    
    func autoLogin() {
        if Auth.auth().currentUser == nil {
            authState.send(.loggeOut)
        } else {
            fetchCurrentUserInfo()
        }
    }
    
    func login(with email: String, and password: String) async throws {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            fetchCurrentUserInfo()
            print("Successfully signed in \(authResult.user.email ?? email)")
        } catch {
            print("failed to logined with email\(email): \(error.localizedDescription)")
            throw AuthError.emailLoginFailed(error.localizedDescription)
        }
    }
    
    func createdAccount(for username: String, with email: String, and password: String) async throws {
        
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let uid = authResult.user.uid
            let newUser = UserItem(uid: uid, username: username, email: email)
            try await saveUserInfoDatebase(user: newUser)
            self.authState.send(.loggedIn(newUser))
        } catch {
            print("failed to create an account: \(error.localizedDescription)")
            throw AuthError.accountCreationFailed(error.localizedDescription)
        }
    }
    
    func logout() async throws {
        do {
            try Auth.auth().signOut()
            authState.send(.loggeOut)
            print("SUccessfully to logout")
        }catch {
            print("failed to logout current user: \(error.localizedDescription)")
        }
    }
    
    
}

extension AuthManager {
    private func saveUserInfoDatebase(user: UserItem) async throws {
        do{
            let userDictinary: [String: Any] = [.uid: user.uid,.username: user.username, .email: user.email]
            try await FirebaseConstants.UserRef.child(user.uid).setValue(userDictinary)
        }catch {
            print("failed to save user info to database: \(error.localizedDescription)")
            throw AuthError.failedToSaveUserInfo(error.localizedDescription)
        }
    }
    
    private func fetchCurrentUserInfo() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(currentUid).observe(.value) { [weak self] snapshot in
            guard let userdictinary = snapshot.value as? [String: Any] else { return }
            let loggedInUser = UserItem(dictionary: userdictinary)
            print("Current user ne \(loggedInUser)")
            self?.authState.send(.loggedIn(loggedInUser))
        }
    }
}


extension AuthManager {
    
    static let testAccounts: [String] = [
        "QaUser1@test.com",
        "QaUser2@test.com",
        "QaUser3@test.com",
        "QaUser4@test.com",
        "QaUser5@test.com",
        "QaUser6@test.com",
        "QaUser7@test.com",
        "QaUser8@test.com",
        "QaUser9@test.com",
        "QaUser10@test.com",
        "QaUser11@test.com",
        "QaUser12@test.com",
        "QaUser13@test.com",
        "QaUser14@test.com",
        "QaUser15@test.com",
        "QaUser16@test.com",
        "QaUser17@test.com",
        "QaUser18@test.com",
        "QaUser19@test.com",
        "QaUser20@test.com",
        "QaUser21@test.com",
        "QaUser22@test.com",
        "QaUser23@test.com",
        "QaUser24@test.com",
        "QaUser25@test.com",
        "QaUser26@test.com",
        "QaUser27@test.com",
        "QaUser28@test.com",
        "QaUser29@test.com",
        "QaUser30@test.com",
        "QaUser31@test.com",
        "QaUser32@test.com",
        "QaUser33@test.com",
        "QaUser34@test.com",
        "QaUser35@test.com",
        "QaUser36@test.com",
        "QaUser37@test.com",
        "QaUser38@test.com",
        "QaUser39@test.com",
        "QaUser40@test.com",
        "QaUser41@test.com",
        "QaUser42@test.com",
        "QaUser43@test.com",
        "QaUser44@test.com",
        "QaUser45@test.com",
        "QaUser46@test.com",
        "QaUser47@test.com",
        "QaUser48@test.com",
        "QaUser49@test.com",
        "QaUser50@test.com"
    ]
}

