//
//  ChannelTabScreen.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 24/1/25.
//

import SwiftUI

struct ChannelTabScreen: View {
    @State private var searchtext: String = ""
   
    @StateObject private var viewModel = ChannelTabViewModel()
    
    var body: some View {
        NavigationStack{
            List {
                archivedButton()
                
                ForEach(viewModel.channels){ channel in
                    NavigationLink {
                        ChatRoomScreen(channel: channel)
                    } label: {
                        ChannelItemView(channel: channel)
                    }
                   
                }
                
                inboxFooterView()
                    .listRowSeparator(.hidden)
            }
            .navigationTitle("Chats")
            .listStyle(.plain)
            .searchable(text: $searchtext)
            .toolbar {
                leadingNavItems()
                trailingNavItems()
            }
            .sheet(isPresented: $viewModel.showChatPartnerPickerView) {
                ChatPartnerPickerScreen {channel in
                    viewModel.onNewChannelCreation(channel)
                }
            }
            .navigationDestination(isPresented: $viewModel.navigationToChatRoom) {
                if let newChannel = viewModel.newChannel{
                    ChatRoomScreen(channel: newChannel)
                }
                
            }
        }
        
    }
}

extension ChannelTabScreen {
    
    //    @ToolbarContentBuilder
    private func leadingNavItems()-> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Menu {
                Button {
                    
                } label: {
                    Label("Select Chats", systemImage: "checkmark.circle")
                }
                
            } label: {
                Image(systemName: "ellipsis.circle")
            }
            
        }
    }
    
    private func trailingNavItems()-> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            aiButton()
            cameraButton()
            newChatButton()
        }
    }
    
    private func aiButton() -> some View {
        Button {
            
        } label: {
            Image(.circle)
        }
    }
    
    private func newChatButton() -> some View {
        Button {
            viewModel.showChatPartnerPickerView = true
        } label: {
            Image(.plus)
        }
    }
    
    private func cameraButton() -> some View {
        Button {
            
        } label: {
            Image(systemName: "camera")
        }
    }
    
    private func archivedButton() -> some View {
        Button {
            
        }label: {
            Label("Archived", systemImage: "archivebox.fill")
                .bold()
                .padding()
                .foregroundStyle(.gray)
        }
    }
    
    private func inboxFooterView() -> some View {
        HStack {
            Image(systemName: "lock.fill")
            
            (
                Text("Your personal messages are ")
                +
                Text("end to end encryted.")
                    .foregroundStyle(.blue)
            )
        }
        .frame(width: .infinity, alignment: .center)
        .foregroundStyle(.gray)
        .font(.caption)
        .padding(.horizontal)
        
    }
}

#Preview {
    ChannelTabScreen()
}
