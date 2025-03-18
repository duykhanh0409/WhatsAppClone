//
//  ChannelItem.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 2/2/25.
//

import Foundation
import FirebaseAuth

struct ChannelItem: Identifiable {
    var id: String
    var name: String?
    var lastMessage: String
    var creationDate: Date
    var lastMessageTimeStamp: Date
    var membersCount: Int
    var adminUids: [String]
    var membersUids: [String]
    var members: [UserItem]
    private var thumbnailUrl: String?
    let createdBy: String
    
    var isGroupChat: Bool {
        return membersCount > 2
    }
    
    var coverImageUrl:String? {
        if let thumbnailUrl = thumbnailUrl {
            return thumbnailUrl
        }
        
        if isGroupChat == false {
            return memebersExcludingMe.first?.profileImageUrl
        }
        
        return nil
    }
    
    var memebersExcludingMe: [UserItem] {
        guard let currentUid = Auth.auth().currentUser?.uid else {return []}
        return members.filter {$0.uid != currentUid}
    }
    
    var title: String {
        if let name = name {
            return name
        }
        
        if isGroupChat {
            return groupMemeberNames
        }else {
            return memebersExcludingMe.first?.username ?? "Unknown user"
        }
    }
    
    static let placeholder = ChannelItem.init(id: "1", lastMessage: "Hello world", creationDate: Date(), lastMessageTimeStamp: Date(), membersCount: 2, adminUids: [], membersUids: [], members: [], createdBy: "")
    
    private var groupMemeberNames: String {
        let memeberCount = membersCount - 1
        let fullNames: [String] = memebersExcludingMe.map {$0.username}
        
        if memeberCount == 2 {
            // username 1 and user name 2
            return fullNames.joined(separator: " and ")
        } else if memeberCount > 2 {
            return fullNames.prefix(2).joined(separator: ", ") + " and \(memeberCount - 2) others"
        }
        
        return "unknow"
    }
    
    var isCreatedByMe: Bool {
        return createdBy == Auth.auth().currentUser?.uid ?? ""
    }
    
    var creatorName: String {
        return members.first {$0.uid == createdBy}?.username ?? "Someone"
    }
    
}

extension ChannelItem {
    init(_ dict: [String: Any]) {
        self.id = dict[.id] as? String ?? ""
        self.name = dict[.name] as? String? ?? nil
        self.lastMessage = dict[.lastMessage] as? String ?? ""
        let creationInterval = dict[.creationDate] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: creationInterval)
        let lastMsgTimeStampInterval = dict[.lastMessageTimeStamp] as? Double ?? 0
        self.lastMessageTimeStamp = Date(timeIntervalSince1970: lastMsgTimeStampInterval)
        self.membersCount = dict[.membersCount] as? Int ?? 0
        self.adminUids = dict[.adminUids] as? [String] ?? []
        self.thumbnailUrl = dict[.thumbnailUrl] as? String ?? nil
        self.membersUids = dict[.membersUids] as? [String] ?? []
        self.members = dict[.members] as? [UserItem] ?? []
        self.createdBy = dict[.createdBy] as? String ?? ""
    }
}

extension String {
    static let id = "id"
    static let name = "name"
    static let lastMessage = "lastMessage"
    static let creationDate = "creationDate"
    static let lastMessageTimeStamp = "lastMessageTimeStamp"
    static let membersCount = "membersCount"
    static let adminUids = "adminUids"
    static let membersUids = "membersUids"
    static let thumbnailUrl = "thumbnailUrl"
    static let members = "members"
    static let createdBy = "createdBy"
}
