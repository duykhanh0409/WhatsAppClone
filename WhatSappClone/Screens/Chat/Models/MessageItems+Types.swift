//
//  Untitled.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 7/2/25.
//

import Foundation

enum AdminMessageType: String {
    case channelCreation
    case memeberAdded
    case memberLeft
    case channelNameChanged
}

enum MessageType {
    case text, photo, video, audio
}

enum MessageDirection {
    case sent, received
    
    static var random: MessageDirection {
        return [.sent , .received].randomElement() ?? .sent
    }
}
