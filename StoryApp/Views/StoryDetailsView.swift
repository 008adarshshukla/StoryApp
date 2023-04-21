//
//  ContentView.swift
//  StoryApp
//
//  Created by Adarsh Shukla on 21/04/23.
//

import SwiftUI
import AVKit

struct StoryDetailsView: View {
    
    @State var player = AVPlayer(url: Bundle.main.url(forResource: "Women",
                                                      withExtension: "mp4")!)
    @State private var selectedTab: Int = 0
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            TabView {
                Image("Constellation")
                    .resizable()
                    .scaledToFill()
                    .tag(0)
                
                Image("Fire")
                    .resizable()
                    .scaledToFill()
                    .tag(1)
                
                Image("Planet")
                    .resizable()
                    .scaledToFill()
                    .tag(3)
                
                Image("Flower")
                    .resizable()
                    .scaledToFill()
                    .tag(4)
                
                VStack {
                    VideoPlayer(player: player)
                        .onAppear {
                            player.seek(to: .zero)
                            player.play()
                        }
                    PlayerControlsView(player: player)
                }
                .tag(5)
                
                
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 20)
            .tabViewStyle(.page(indexDisplayMode: .always))
            .onTapGesture {
                
            }
        }
    }
}

struct StoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        StoryDetailsView()
    }
}

