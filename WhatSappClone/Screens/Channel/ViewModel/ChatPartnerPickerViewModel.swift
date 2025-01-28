//
//  ChatPartnerPickerViewModel.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 27/1/25.
//

import Foundation

enum ChannelCreationRoute {
    case addGroupChatMembers
    case setUpGroupChat
}

final class ChatPartnerPickerViewModel: ObservableObject {
    @Published var navStack = [ChannelCreationRoute]()
    @Published var selectedChatPartners = [UserItem]()
    
    var showSelectedUsers: Bool {
        return !selectedChatPartners.isEmpty
    }
    
    
    // MARK: - Public Methods
    func handleItemSelection(_ item: UserItem) {
        if isUserSelected(item) {
            guard let index = selectedChatPartners.firstIndex(where: { $0.uid == item.uid }) else { return }
            selectedChatPartners.remove(at: index)
        } else {
            selectedChatPartners.append(item)
        }
    }
    
    func isUserSelected(_ user: UserItem) -> Bool {
        let isSelected = selectedChatPartners.contains { $0.uid == user.uid }
        return isSelected
    }
}
