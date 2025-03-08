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
    
    var title: String {
        switch self {
        case .text:
            return "text"
        case .photo:
            return "photo"
        case .video:
            return "video"
        case .audio:
            return "audio"
        }
    }
}

enum MessageDirection {
    case sent, received
    
    static var random: MessageDirection {
        return [.sent , .received].randomElement() ?? .sent
    }
}
