//
//  ChatRoomViewModel.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 8/3/25.
//

import Foundation
import Combine

final class ChatRoomViewModel: ObservableObject {
    @Published var textMessage = ""
    private var channel: ChannelItem
    private var subscription = Set<AnyCancellable>()
    
    @Published var currentUser: UserItem?
    
    init(channel: ChannelItem) {
        self.channel = channel
        listenToAuthState()
    }
    
    deinit {
        subscription.forEach{$0.cancel()}
        subscription.removeAll()
        currentUser = nil
    }
    
    private func listenToAuthState() {
        AuthManager.shared.authState.receive(on: DispatchQueue.main).sink { authState in
            switch authState {
            case .loggedIn(let currentUser):
                self.currentUser = currentUser
            default :
                break
            }
            
        }
        .store(in: &subscription)
    }
    
    func sendMessage() {
        MessageService.sentTextMessage(to: channel, from: currentUser, textMessage) {
            self.textMessage = ""
            print("Message is sending")
        }
    }
}
