//
//  ChannelTabViewModel.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 2/2/25.
//

import Foundation
import Firebase
import FirebaseAuth

final class ChannelTabViewModel: ObservableObject {
    @Published var navigationToChatRoom = false
    @Published var newChannel: ChannelItem?
    @Published  var showChatPartnerPickerView = false
    @Published var channels = [ChannelItem]()
    
    init() {
        fetchCurrentUserChannels()
    }
    
    func onNewChannelCreation(_ channel: ChannelItem){
        showChatPartnerPickerView = false
        newChannel = channel
        navigationToChatRoom = true
    }
    
    
    private func fetchCurrentUserChannels(){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        FirebaseConstants.UserChannelsRef.child(currentUid).observe(.value) { [weak self] snapshot in
            guard let dict = snapshot.value as? [String: Any] else { return }
            dict.forEach { key, _ in
                let channelId = key
                self?.getChannel(with: channelId)
            }
        } withCancel: { error in
            print("Failed to fetch current user channels: \(error.localizedDescription)")
        }
    }
    
    private func getChannel(with channelId: String) {
        FirebaseConstants.ChannelsRef.child(channelId).observe(.value) { snapshot in
            guard let dict = snapshot.value as? [String: Any] else { return }
            var channel = ChannelItem(dict)
            self.getChannelMembers(channel) { members in
                channel.members = members
                self.channels.append(channel)
                print("Channel members: \(channel.title)")
            }
        } withCancel: { error in
            print("Failed to fetch channel: \(error.localizedDescription)")
        }

    }
    
    private func getChannelMembers(_ channel: ChannelItem, completion: @escaping (_ members:[UserItem]) -> Void) {
        UserService.getUsers(with: channel.membersUids) { userNode in
            completion(userNode.users)
        }
        
    }
    
}
