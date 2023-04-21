//
//  ContentView.swift
//  StoryApp
//
//  Created by Adarsh Shukla on 21/04/23.
//

import SwiftUI
import AVKit

struct StoryDetailsView: View {
    
    @State var player = AVPlayer(url: Bundle.main.url(forResource: "Women",withExtension: "mp4")!)
    @Environment(\.dismiss) var dismiss
    @State private var selectedTab: Int = 0
    @State var isSwipeDisabled: Bool = true
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            TabView(selection: $selectedTab) {
                Image("Constellation")
                    .resizable()
                    .scaledToFill()
                    .tag(0)
                    .gesture(isSwipeDisabled ? DragGesture() : nil)
                
                Image("Fire")
                    .resizable()
                    .scaledToFill()
                    .tag(1)
                    .gesture(isSwipeDisabled ? DragGesture() : nil)
                
                Image("Planet")
                    .resizable()
                    .scaledToFill()
                    .tag(2)
                    .gesture(isSwipeDisabled ? DragGesture() : nil)
                
                Image("Flower")
                    .resizable()
                    .scaledToFill()
                    .tag(3)
                    .gesture(isSwipeDisabled ? DragGesture() : nil)
                
                VStack {
                    VideoPlayer(player: player)
                        .onAppear {
                            player.seek(to: .zero)
                            player.play()
                        }
                    PlayerControlsView(player: player)
                }
                .tag(4)
                .gesture(isSwipeDisabled ? DragGesture() : nil)
                
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 20)
            .tabViewStyle(.page(indexDisplayMode: .always))
            .onTapGesture {
                if selectedTab >= 0 && selectedTab < 4 {
                    selectedTab += 1
                    print(self.selectedTab)
                }
                else {
                    dismiss()
                }
            }
        }
    }
}

struct StoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        StoryDetailsView()
    }
}

