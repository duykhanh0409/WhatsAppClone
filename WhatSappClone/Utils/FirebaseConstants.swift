//
//  FirebaseConstants.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 26/1/25.
//

import Foundation
import Firebase
import FirebaseStorage

enum FirebaseConstants {
    private static let DatabaseRef = Database.database().reference()
    static let UserRef = DatabaseRef.child("users")
}

