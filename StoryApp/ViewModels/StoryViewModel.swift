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
            Story(isImage: true, imageURL: "Planet"),
            Story(isImage: true, imageURL: "Smoke"),
            Story(isImage: true, imageURL: "Fire"),
            Story(isImage: false, imageURL: "")
        ]),
        StoryBundle(profileName: "Carl", profileImage: "Person2", stories: [
            Story(isImage: true, imageURL: "Constellation"),
            Story(isImage: true, imageURL: "Flower"),
            Story(isImage: true, imageURL: "Fireworks"),
            Story(isImage: false, imageURL: "")
        ]),
    ]
    
    //MARK: Properties.
    @Published var showStory: Bool = false
    //MARK: Will be unique Story Bundle Id
    @Published var currentStory: String = ""
}
