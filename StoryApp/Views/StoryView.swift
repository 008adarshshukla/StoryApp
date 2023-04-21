//
//  StoryView.swift
//  StoryApp
//
//  Created by Adarsh Shukla on 21/04/23.
//

import SwiftUI

struct StoryView: View {
    
    @State private var usernames: [String] = ["James", "Mark", "Carl", "Emma",
    "Olivia"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                currentUserProfileView()
                ForEach(1...5, id: \.self) { index in
                    otherUsersProfileView(index: index)
                }
            }
        }
    }
    
    //MARK: Profile View
    @ViewBuilder
    func otherUsersProfileView(index: Int) -> some View {
        VStack(spacing: 5) {
            Circle()
                .stroke(lineWidth: 4)
                .fill(LinearGradient(colors: [Color(hex: "fa7e1e"), Color(hex: "d62976")], startPoint: .bottomLeading, endPoint: .topTrailing))
                .frame(width: 85, height: 90)
                .overlay(alignment: .center) {
                    Image("Person\(index)")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                }
            
            Text(usernames[index - 1])
                .fontWeight(.semibold)
        }
    }
    
    //MARK: Profile view for the current user.
    @ViewBuilder
    func currentUserProfileView() -> some View {
        VStack(spacing: 5) {
            Circle()
                .stroke(lineWidth: 4)
                .fill(LinearGradient(colors: [Color(hex: "fa7e1e"), Color(hex: "d62976")], startPoint: .bottomLeading, endPoint: .topTrailing))
                .frame(width: 85, height: 90)
                .overlay(alignment: .center) {
                    Image("Me")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .overlay(alignment: .bottomTrailing) {
                            Circle()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.blue)
                                .overlay(alignment: .center) {
                                    Image(systemName: "plus")
                                        .bold()
                                        .foregroundColor(.white)
                                }
                        }
                }
            
            Text("Your story")
                .fontWeight(.semibold)
        }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView()
    }
}
