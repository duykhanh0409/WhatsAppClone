//
//  UpdatesTabScreen.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 23/1/25.
//

import SwiftUI

struct UpdatesTabScreen: View {
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            List {
                StatusSectionHeader()
                    .listRowBackground(Color.clear)
                
                StatusSection()
                
                Section {
                    RecentUpdatesItemView()
                }header: {
                    Text("Recent updates")
                }
                
                Section {
                    ChannelListView()
                }header: {
                    ChannelSectionHeader()
                }
                
                
            }
            .listStyle(.grouped)
            .navigationTitle("Updates")
            .searchable(text: $searchText)
        }
        
    }
    
}

private struct StatusSectionHeader: View {
    var body: some View {
        HStack(alignment: .top) {
            
            Image(systemName: "circle.dashed")
                .foregroundStyle(.blue)
                .imageScale(.large)
            Spacer()
            (
                Text("Use status to share photos, text and videos that disappear in 24 hours     ")
                +
                Text(" ")
                +
                Text("Status privacy")
                    .foregroundColor(.blue).bold()
            )
            Spacer()
            Image(systemName: "xmark")
                .foregroundStyle(.gray)
            
        }
        .padding()
        .background(.whatsAppWhite)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

private struct StatusSection: View {
    var body: some View {
        HStack {
            Circle()
                .frame(width: UpdatesTabScreen.Constant.staticDimen, height: UpdatesTabScreen.Constant.staticDimen)
                .foregroundColor(.black)
            
            VStack(alignment: .leading) {
                Text("My status")
                    .font(.callout)
                    .bold()
                Text("Add to my status")
                    .foregroundStyle(.gray)
                    .font(.system(size: 15))
            }
            Spacer()
            
            RightButton(label: "camera.fill")
            RightButton(label: "pencil")
        }
    }
    
    private func RightButton(label: String) -> some View {
        Button {
            
        } label: {
            Image(systemName: label)
                .padding(10)
                .background(Color(.systemGray5))
                .clipShape(Circle())
                .bold()
        }
        
    }
}

private struct RecentUpdatesItemView: View {
    var body: some View {
        HStack {
            Circle()
                .frame(width: UpdatesTabScreen.Constant.staticDimen, height: UpdatesTabScreen.Constant.staticDimen)
                .foregroundColor(.black)
            
            VStack(alignment: .leading) {
                Text("Khanh")
                    .font(.callout)
                    .bold()
                Text("1 Hours ago")
                    .foregroundStyle(.gray)
                    .font(.system(size: 15))
            }
            
        }
    }
}

private struct ChannelListView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Stay update on topics that matter to you. Find channel to follow below.")
                .foregroundStyle(.gray)
                .font(.callout)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false ) {
                HStack {
                    ForEach(0..<5) { _ in
                        ChannelItemView()
                    }
                }
            }
            
            Button("Explore More") {

            }
            .tint(Color.blue)
            .bold()
            .buttonStyle(.borderedProminent)
            .font(.callout)
            .clipShape(.capsule)
            .padding(.vertical)
            
        }
    }
}

private struct ChannelItemView: View {
    var body: some View {
        VStack {
            Circle()
                .frame(width: UpdatesTabScreen.Constant.staticDimen, height: UpdatesTabScreen.Constant.staticDimen)
            Text("Real madrid FC")
            Button {
                
            } label: {
                Text("Follow")
                    .bold()
                    .padding(5)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.2))
                    .clipShape(.capsule)
                
            }

        }
        .padding(.horizontal,16)
        .padding(.vertical)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 1)
        }
    }
}

private func ChannelSectionHeader() -> some View {
    HStack{
        Text("Channels")
            .bold()
            .font(.title3)
            .textCase(nil)
            .foregroundStyle(.whatsAppBlack)
        
        Spacer()
        
        Button {
            
        } label: {
            Image(systemName: "plus")
                .padding(7)
                .background(Color(.systemGray5))
                .clipShape(.circle)
        }

    }
}

extension UpdatesTabScreen {
    enum Constant {
        static let staticDimen: CGFloat = 55
    }
}

#Preview {
    UpdatesTabScreen()
}
