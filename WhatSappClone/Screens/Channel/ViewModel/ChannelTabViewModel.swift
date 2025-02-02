//
//  ChannelTabViewModel.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 2/2/25.
//

import Foundation

final class ChannelTabViewModel: ObservableObject {
    @Published var navigationToChatRoom = false
    @Published var newChannel: ChannelItem?
    @Published  var showChatPartnerPickerView = false
    
    func onNewChannelCreation(_ channel: ChannelItem){
        showChatPartnerPickerView = false
        newChannel = channel
        navigationToChatRoom = true
    }
}
