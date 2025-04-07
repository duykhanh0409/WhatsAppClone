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
    @Published var messages = [MessageItem]()
    private(set) var channel: ChannelItem
    private var subscription = Set<AnyCancellable>()
    
    private var currentUser: UserItem?
    
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
                if self.channel.allMemebersFetched {
                    self.getMessages()
                }else {
                    self.getAllChannelMembers()
                }
                self.getAllChannelMembers()
//                self.getMessages()
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
    
    private func getMessages() {
        MessageService.getMessage(for: channel) { [weak self] messages  in
            self?.messages = messages
        }
    }
    
    private func getAllChannelMembers() {
        guard let currentUser = currentUser else { return }
        let memebersAlreadyFetched = channel.members.compactMap { $0.uid }
        var memeberUIDToFetch = channel.membersUids.filter { !memebersAlreadyFetched.contains($0) }
        memeberUIDToFetch = memeberUIDToFetch.filter {$0 != currentUser.uid}
        
        UserService.getUsers(with: memeberUIDToFetch) {[weak self] userNode in
            guard let self = self else {return}
            self.channel.members.append(contentsOf: userNode.users)
            self.channel.members.append(currentUser)
            self.getMessages()
        }
    }
}
