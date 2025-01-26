//
//  RootScreen.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 26/1/25.
//

import SwiftUI

struct RootScreen: View {
    @StateObject private var viewModel = RootScreenModel()
    var body: some View {
        switch viewModel.authState {
        case .pending:
            ProgressView()
                .controlSize(.large)
        case .loggedIn(_):
            MainTabView()
        case .loggeOut:
            LoginScreen()
        }
    }
}

#Preview {
    RootScreen()
}
