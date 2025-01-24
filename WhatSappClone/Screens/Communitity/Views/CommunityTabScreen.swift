//
//  CommunityTabScreen.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 24/1/25.
//

import SwiftUI

struct CommunityTabScreen: View {
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading) {
                    Image(.communities)
                    
                    Group {
                        Text("Stay connected with a community")
                            .font(.title2)
                        
                        Text("Communities bring members together in topic-based groups. Any cominity you're added to will appear here.")
                            .foregroundStyle(.gray)
                        
                    }
                    .padding(.horizontal, 5)
                    
                    Button("See example communities >"){
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical,10)
                    
                    createNewComminityButton()
                }
                .padding()
                .navigationTitle("Communities")
            }
        }
    }
    
    private func createNewComminityButton() -> some View {
        Button {
            
        } label: {
            Label("New Community", systemImage: "plus")
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundStyle(.white)
                .padding(10)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .padding()
            
        }

    }
}

#Preview {
    CommunityTabScreen()
}
