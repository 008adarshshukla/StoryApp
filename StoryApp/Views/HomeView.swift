//
//  HomeView.swift
//  StoryApp
//
//  Created by Adarsh Shukla on 21/04/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var storyData = StoryViewModel()
    
    var body: some View {
        NavigationStack {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                ScrollView(.horizontal, showsIndicators: false) {
                    //MARK: Showing user stories.
                    HStack(spacing: 12) {
                        Button {
                            
                        } label: {
                            Image("Me")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .overlay(alignment: .bottomTrailing) {
                                    Image(systemName: "plus")
                                        .padding(8)
                                        .background(.blue, in: Circle())
                                        .foregroundColor(.white)
                                        .padding(2)
                                        .background(.black, in: Circle())
                                        .offset(x: 10, y: 10)
                                }
                        }
                        .padding(.trailing, 10)
                        
                        //MARK: Stories
                        ForEach($storyData.stories) { $bundle in
                            //MARK: Profile View
                            ProfileView(bundle: $bundle)
                                .environmentObject(storyData)
                        }

                    }
                    .padding()
                    .padding(.top, 10)
                }
            }
            .navigationTitle("Instagram")
        }
        .overlay(alignment: .center) {
            StoryView()
                .environmentObject(storyData)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


