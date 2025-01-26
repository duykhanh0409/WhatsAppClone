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
            

    }
}
