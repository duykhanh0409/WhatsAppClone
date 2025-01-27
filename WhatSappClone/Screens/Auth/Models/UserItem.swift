//
//  UserItem.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 26/1/25.
//

import Foundation


struct UserItem: Identifiable, Hashable, Decodable {
    let uid: String
    let userName: String
    let email: String
    var bio: String? = nil
    var profileImageUrl: String? = nil
    
    var id: String { return uid }
    
    var bioUnwrapped: String {
        return bio ?? "Hey there! I am using whatsapp"
    }
    
    static let placehodlder = UserItem(
        uid: "1",
        userName: "Khanh",
        email: "Khanh@gmail.com"
    )
}

extension UserItem {
    init(dictionary: [String: Any]){
        self.uid = dictionary[String.uid] as? String ?? ""
        self.userName = dictionary[String.username] as? String ?? ""
        self.email = dictionary[String.email] as? String ?? ""
        self.bio = dictionary[String.bio] as? String ?? nil
        self.profileImageUrl = dictionary[String.profileImageUrl] as? String ?? nil
    }
}

extension String {
    static let uid = "uid"
    static let username = "username"
    static let email = "email"
    static let bio = "bio"
    static let profileImageUrl = "profileImageUrl"
}
