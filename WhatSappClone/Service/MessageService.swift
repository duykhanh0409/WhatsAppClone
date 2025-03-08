//
//  MessageService.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 8/3/25.
//

import Foundation

//hanles sending and fetching message

struct MessageService {
    
    static func sentTextMessage(to channel: ChannelItem, from currentUser: UserItem?, _ textMessage: String, onComplete:(() -> Void)) {
        let timeStamp = Date().timeIntervalSince1970
        guard let messageId = FirebaseConstants.MessageRef.childByAutoId().key else {
            return
        }
        
        let channelDict: [String: Any] = [
            .lastMessage: textMessage,
            .lastMessageTimeStamp: timeStamp,        ]
        
        let messageDict: [String: Any] = [
            .text: textMessage,
            .type: MessageType.text.title,
            .timeStamp: timeStamp,
            .owerUid: currentUser?.uid ?? "",
        ]
        
        FirebaseConstants.ChannelsRef.child(channel.id).updateChildValues(channelDict)
        FirebaseConstants.MessageRef.child(channel.id).child(messageId).setValue(messageDict)
        
        onComplete()
    }
}
