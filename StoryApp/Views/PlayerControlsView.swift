//
//  PlayControlsView.swift
//  StoryApp
//
//  Created by Adarsh Shukla on 21/04/23.
//

import SwiftUI
import AVKit

struct PlayerControlsView : View {
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var playerPaused = true
    @State var seekPos = 0.0
    let player: AVPlayer
    
    var body: some View {
        HStack {
            Button(action: {
                self.playerPaused.toggle()
                if self.playerPaused {
                    self.player.pause()
                }
                else {
                    self.player.play()
                }
            }) {
                Image(systemName: playerPaused ? "play" : "pause")
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
            }
            
            Slider(value: $seekPos, in: 0...1, step: 0.1)
                .padding(.trailing, 20)
            
        }
        .onReceive(timer, perform: { _ in
            guard let item = self.player.currentItem else {
                return
            }
            self.seekPos = item.currentTime().seconds / item.duration.seconds
            
            if player.currentTime().seconds >= item.duration.seconds {
                self.playerPaused = true
                self.timer.upstream.connect().cancel()
            }
        })
        .onAppear {
            self.playerPaused = false
        }
    }
}
