//
//  StoryCardView.swift
//  StoryApp
//
//  Created by Adarsh Shukla on 22/04/23.
//

import SwiftUI

struct StoryCardView: View {
    
    @Binding var bundle: StoryBundle
    @EnvironmentObject var storyData: StoryViewModel
    
    //MARK: Changing the stories based on the Timer
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    //MARK: Progress...
    @State private var timerProgress: CGFloat = 0
    
    var body: some View {
        
        //For 3D rotation...
        GeometryReader { proxy in
            
            ZStack {
                //MARK: Getting current index and updating data.
                let index = min(Int(timerProgress), bundle.stories.count - 1)
                
                let story = bundle.stories[index]
                
                if story.isImage {
                    Image(story.imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                else {
                    VideoPlayerView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
            //MARK: Handle Tap Event
            .overlay(alignment: .bottom, content: {
                
                HStack {
                    Rectangle()
                        .fill(.black.opacity(0.01))
                        .onTapGesture {
                            if (timerProgress - 1) < 0 {
                                updateStory(forward: false)
                            } else {
                                timerProgress = CGFloat(Int(timerProgress - 1))
                            }
                        }
                    
                    Rectangle()
                        .fill(.black.opacity(0.01))
                        .onTapGesture {
                            //MARK: checking and updating to next.
                            if (timerProgress + 1) > CGFloat(bundle.stories.count) {
                                //MARK: Update to next Bundle.
                                updateStory()
                            }
                            else {
                                //MARK: Upadate to next story.
                                timerProgress = CGFloat(Int(timerProgress + 1))
                            }
                        }
                }
            })
            
            //MARK: Close Button
            .overlay(alignment: .topTrailing) {
                //MARK: Top profile view
                HStack(spacing: 13, content: {
                    
                    Image(bundle.profileImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                    
                    Text(bundle.profileName)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            storyData.showStory = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                })
                .padding()

            }
            
            //MARK: Top Timer Capsule
            .overlay(alignment: Alignment.top, content: {
                HStack(spacing: 5) {
                    ForEach(bundle.stories.indices) { index in
                        GeometryReader { proxy in
                            let width = proxy.size.width
                            
                            //MARK: Getting the progress by eliminating the current index with progress. so that remaining all will be at 0 when previous is loading.
                            
                            let progress = timerProgress - CGFloat(index)
                            let perfectProgress = min(max(progress, 0), 1)
                            
                            Capsule()
                                .fill(.gray.opacity(0.5))
                                .overlay(alignment: Alignment.leading) {
                                    Capsule()
                                        .fill(.white)
                                        .frame(width: width * perfectProgress)
                                }
                        }
                    }
                }
                .frame(height: 1.4)
                .padding(.horizontal)
            })
            
            //MARK: Rotation
            .rotation3DEffect(getAngle(proxy: proxy),
                              axis: (x: 0, y: 1, z: 0),
                              anchor: proxy.frame(in: .global).minX > 0 ? .leading : .trailing,
                              perspective: 2.5)
        }
        //MARK: Resting timer
        .onAppear {
            timerProgress = 0
        }
        
        .onReceive(timer) { _ in
            //MARK: Updating seen status on Realtime
            if storyData.currentStory == bundle.id {
                if !bundle.isSeen {
                    bundle.isSeen = true
                }
                
                //MARK: Updating timer
                if timerProgress < CGFloat(bundle.stories.count) {
                    timerProgress += 0.03
                } else {
                    updateStory()
                }
            }
        }
    }
    
    //MARK: Updating new story on the end of the other.
    func updateStory(forward: Bool = true) {
        let index = min(Int(timerProgress), bundle.stories.count - 1)
        let story = bundle.stories[index]
        
        if !forward {
            //MARK: if its not first then moving backwards else set timer to 0
            if let first = storyData.stories.first, first.id != bundle.id {
                
                //MARK: Getting the index
                let bundleIndex = storyData.stories.firstIndex { currentBundle in
                    return bundle.id == currentBundle.id
                } ?? 0
                
                withAnimation {
                    storyData.currentStory = storyData.stories[bundleIndex - 1].id
                }
                
            } else {
                timerProgress = 0
            }
            return
        }
        
        //MARK: Checking if its last
        if let last = bundle.stories.last, last.id == story.id {
            //MARK: if there is another story then moving to that else closing the view.
            if let lastBundle = storyData.stories.last, lastBundle.id == bundle.id {
                //MARK: Closing
                withAnimation {
                    storyData.showStory = false
                }
            } else {
                //MARK: Updating to next.
                let bundleIndex = storyData.stories.firstIndex { currentBundle in
                    return bundle.id == currentBundle.id
                } ?? 0
                
                withAnimation {
                    storyData.currentStory = storyData.stories[bundleIndex + 1].id
                }
            }
        }
    }
    
    //MARK: Function to get angle with respect to the progress.
    func getAngle(proxy: GeometryProxy) -> Angle {
        //MARK: Converting offset into the 45 degree rotation.
        let progress = proxy.frame(in: .global).minX / proxy.size.width
        let rotationAngle: CGFloat = 45
        let degrees = rotationAngle * progress
        
        return Angle(degrees: Double(degrees))
    }
}
