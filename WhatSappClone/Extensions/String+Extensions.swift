//
//  String+Extensions.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 2/2/25.
//

import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool { return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty}
}
