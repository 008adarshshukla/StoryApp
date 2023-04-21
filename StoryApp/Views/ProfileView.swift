//
//  ProfileView.swift
//  StoryApp
//
//  Created by Adarsh Shukla on 22/04/23.
//

import SwiftUI

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
