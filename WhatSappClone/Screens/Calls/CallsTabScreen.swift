//
//  CallsTabScreen.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 23/1/25.
//

import SwiftUI

struct CallsTabScreen: View {
    @State private var searchText: String = ""
    @State private var callHistory = CallHistory.all
    var body: some View {
        NavigationStack{
            List {
                Section {
                    CreateCallLinkSection()
                }
                
                Section {
                    ForEach(0..<12) { _ in
                        RecentCallItemView()
                    }
                } header: {
                    Text("Recent")
                        .textCase(nil)
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.whatsAppBlack)
                }
            }
            .navigationTitle("Calls")
            .searchable(text: $searchText)
            .toolbar {
                leadingNavItems()
                trailingNavItems()
                principalNavItems()
            }
        }
    }
}

extension CallsTabScreen {
    @ToolbarContentBuilder
    private func trailingNavItems() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                
            } label: {
                Image(systemName: "phone.arrow.up.right")
            }
            
        }
        
    }
    
    @ToolbarContentBuilder
    private func leadingNavItems() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button("Edit"){}
            
        }
        
    }
    
    @ToolbarContentBuilder
    private func principalNavItems() -> some ToolbarContent {
        ToolbarItemGroup(placement: .principal) {
            Picker("", selection: $callHistory ) {
                ForEach(CallHistory.allCases) { item in
                    Text(item.rawValue.capitalized)
                        .tag(item)
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 150)
        }
    }
    
    private enum CallHistory: String, CaseIterable, Identifiable {
        case all, missd
        var id: String { return
            rawValue }
        
    }
}

private struct CreateCallLinkSection: View {
    var body: some View {
        HStack{
            Image(systemName: "link")
                .padding()
                .background(Color(.systemGray6))
                .clipShape(Circle())
                .foregroundStyle(.blue)
            VStack(alignment: .leading) {
                Text("Create Call Link")
                    .foregroundStyle(.blue)
                Text("Share a link for you whatsapp call")
                    .foregroundStyle(.gray)
                    .font(.caption)
            }
            
        }
    }
}

private struct RecentCallItemView: View {
    var body: some View {
        HStack{
            Circle()
                .frame(width: 45, height: 45)
            
            recentCallsTextview()
            
            Spacer()
            
            Text("Yesterday")
                .foregroundStyle(.gray)
                .font(.system(size: 16))
            
            Image(systemName: "info.circle")
        }
    }
    
    private func recentCallsTextview() -> some View {
        VStack(alignment: .leading) {
            Text("Khanh Nguyen")
            
            HStack(spacing: 5){
                Image(systemName: "phone.arrow.up.right.fill")
                Text("Outgoing")
            }
            .font(.system(size: 14))
            .foregroundStyle(.gray)
        }
    }
}



#Preview {
    CallsTabScreen()
}
