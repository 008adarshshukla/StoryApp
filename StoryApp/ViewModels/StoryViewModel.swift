//
//  StoryViewModel.swift
//  StoryApp
//
//  Created by Adarsh Shukla on 21/04/23.
//

import SwiftUI

class StoryViewModel: ObservableObject {
    
    @Published var stories: [StoryBundle] = [
        StoryBundle(profileName: "Mark", profileImage: "Person1", stories: [
            Story(imageURL: "Planet"),
            Story(imageURL: "Smoke"),
            Story(imageURL: "Fire")
        ]),
        StoryBundle(profileName: "Carl", profileImage: "Person2", stories: [
            Story(imageURL: "Constellation"),
            Story(imageURL: "Flower"),
            Story(imageURL: "Fireworks")
        ]),
    ]
    
    //MARK: Properties.
    @Published var showStory: Bool = false
    //MARK: Will be unique Story Bundle Id
    @Published var currentStory: String = ""
}
