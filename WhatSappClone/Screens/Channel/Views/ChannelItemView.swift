//
//  ChannelItemView.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 25/1/25.
//

import SwiftUI

struct ChannelItemView: View {
    let channel: ChannelItem
    var body: some View {
        HStack(alignment:.top) {
            CircularProfileImageView(channel, size: .medium)
            
            VStack(alignment: .leading, spacing: 3) {
                titleTextView()
                lastMessagePreview()
            }
        }
    }
    
    private func titleTextView() -> some View {
        HStack {
            Text(channel.title)
                .lineLimit(1)
                .bold()
            
            Spacer()
            
            Text("5:50 PM")
                .foregroundStyle(.gray)
                .font(.system(size: 15))
        }
    }
    
    private func lastMessagePreview() -> some View {
        Text(channel.lastMessage)
            .font(.system(size: 16))
            .lineLimit(2)
    }
}

#Preview {
    ChannelItemView(channel: .placeholder)
}
