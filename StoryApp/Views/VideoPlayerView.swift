//
//  VideoPlayerView.swift
//  StoryApp
//
//  Created by Adarsh Shukla on 21/04/23.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    var body: some View {
        VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: "Women", withExtension: "mp4")!))
            .edgesIgnoringSafeArea(.all)
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView()
    }
}
