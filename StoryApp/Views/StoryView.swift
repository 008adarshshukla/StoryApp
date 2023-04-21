//
//  StoryView.swift
//  StoryApp
//
//  Created by Adarsh Shukla on 21/04/23.
//

import SwiftUI

struct StoryView: View {
    
    @EnvironmentObject var storyData: StoryViewModel
    
    var body: some View {
        
        if storyData.showStory {
            TabView(selection: $storyData.currentStory) {
                //MARK: Stories..
                ForEach($storyData.stories) { $bundle in
                    StoryCardView(bundle: $bundle)
                        .environmentObject(storyData)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            //MARK: This view transitions from the bottom.
            .transition(.move(edge: .bottom))
        }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


