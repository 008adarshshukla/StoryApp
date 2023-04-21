//
//  VideoPlayerView.swift
//  StoryApp
//
//  Created by Adarsh Shukla on 22/04/23.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    
    @State var player = AVPlayer(url: Bundle.main.url(forResource: "VideoFile", withExtension: "mp4")!)
    
    var body: some View {
        VideoPlayer(player: player)
            .frame(width: 400, height: 400, alignment: .center)
            .onAppear {
                player.seek(to: .zero)
                player.play()
            }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView()
    }
}
