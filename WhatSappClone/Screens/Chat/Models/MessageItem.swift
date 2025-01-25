//
//  MessageItem.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 25/1/25.
//

import Foundation
import SwiftUI

struct MessageItem: Identifiable {
    let id = UUID().uuidString
    let text: String
    let type: MessageType
    let direction: MessageDirection
    
    static let sentPlaceholder = MessageItem(text: "Holy Spagetti", type: .text, direction: .sent)
    static let receivedPlaceholder = MessageItem(text: "Hey Dude whats up ", type: .text, direction: .received)

    var alignment: Alignment {
        return direction == .received ? .leading : .trailing
    }
    
    var horizontalAlignment: HorizontalAlignment {
        return direction == .received ? .leading : .trailing
    }
    
    var backgroundColor: Color {
        return direction == .sent ? .bubbleGreen : .bubbleWhite
    }
    
    static let stubMessages: [MessageItem] = [
        MessageItem(text: "Hi There", type: .text, direction: .sent),
        MessageItem(text: "Check out this Photo", type: .photo, direction: .received),
        MessageItem(text: "Play out this Video", type: .video, direction: .sent),
        MessageItem(text: "Audio", type: .audio, direction: .sent)
    ]
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


