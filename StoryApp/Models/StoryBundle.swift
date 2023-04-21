//
//  StoryBundle.swift
//  StoryApp
//
//  Created by Adarsh Shukla on 21/04/23.
//

import SwiftUI

//MARK: StoryBundle Model and Sample Stories.
//MARK: StoryBundle -> Number of stories for each users

struct StoryBundle: Identifiable, Hashable {
    var id = UUID().uuidString
    var profileName: String
    var profileImage: String
    var isSeen: Bool = false
    var stories: [Story]
}

struct Story: Identifiable, Hashable {
    var id = UUID().uuidString
    var imageURL: String
}
