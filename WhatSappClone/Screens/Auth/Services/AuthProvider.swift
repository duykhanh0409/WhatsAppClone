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
    
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .accountCreationFailed(let description):
            return description
        case .failedToSaveUserInfo(let description):
            return description
        }
    }
}

final class AuthManager: AuthProvider {
    
    private init() {
        Task {
            await autoLogin()
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
        
    }
    
    func createdAccount(for username: String, with email: String, and password: String) async throws {
        
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let uid = authResult.user.uid
            let newUser = UserItem(uid: uid, userName: username, email: email)
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
            let userDictinary: [String: Any] = [.uid: user.uid,.username: user.userName, .email: user.email]
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


