//
//  HomeView.swift
//  StoryApp
//
//  Created by Adarsh Shukla on 21/04/23.
//

import SwiftUI

//struct HomeView: View {
//
//    var body: some View {
//        ZStack {
//            Color.black
//                .edgesIgnoringSafeArea(.all)
//            VStack {
//                StoryHeaderView()
//                Spacer()
//            }
//        }
//    }
//}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}


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

struct ProfileView: View {
    
    @Binding var bundle: StoryBundle
    @Environment(\.colorScheme) var scheme
    @EnvironmentObject var storyData: StoryViewModel
    
    var body: some View {
        
        Image(bundle.profileImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 50, height: 50)
            .clipShape(Circle())
        //MARK: Show progress ring if not seen
            .padding(2)
            .background(scheme == .dark ? .black : .white, in: Circle())
            .padding(3)
            .background {
                LinearGradient(colors: [.red, .orange, .red, .orange],
                               startPoint: .top,
                               endPoint: .bottom)
                .clipShape(Circle())
                .opacity(bundle.isSeen ? 0 : 1)
            }
            .onTapGesture {
                withAnimation(Animation.easeInOut) {
                    bundle.isSeen = true
                    //MARK: Saving current bundle and toggling the story.
                    storyData.currentStory = bundle.id
                    storyData.showStory = true
                }
            }
    }
}
