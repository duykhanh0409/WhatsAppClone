//
//  MainTabView.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 23/1/25.
//

import SwiftUI

struct MainTabView: View {
    
    init(){
        makeTabBarOpaque()
    }
    
    var body: some View {
        TabView {
            placeHolderItemView("Updates")
                .tabItem {
                    Image(systemName: Tab.updates.icon)
                }
            placeHolderItemView("Calls")
                .tabItem {
                    Image(systemName: Tab.calls.icon)
                }
            placeHolderItemView("Communities")
                .tabItem {
                    Image(systemName: Tab.communities.icon)
                }
            placeHolderItemView("Chats")
                .tabItem {
                    Image(systemName: Tab.chats.icon)
                }
            placeHolderItemView("Settings")
                .tabItem {
                    Image(systemName: Tab.settings.icon)
                }
        }
    }
    
    private func makeTabBarOpaque(){
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().standardAppearance = appearance
        UIView.appearance().backgroundColor = .systemBackground
    }
}

extension MainTabView {
    
    private func placeHolderItemView(_ title: String) -> some View {
        Text(title)
    }
    private enum Tab: String {
        case updates, calls, communities, chats, settings
        
        fileprivate var title: String {
            return rawValue.capitalized
        }
        
        fileprivate var icon: String {
            switch self {
            case .updates:
                return "person.crop.circle.dashed"
            case .calls:
                return "phone"
            case .communities:
                return "person.3"
            case .chats:
                return "message"
            case .settings:
                return "gearshape"
            }
        }
    }
    
    
}

#Preview {
    MainTabView()
}
