//
//  ExplorerDetail.swift
//  XPlore
//
//  Created by Bryan Khufa on 02/05/21.
//

import SwiftUI
import URLImage

struct ExplorerDetail: View {
    let explorer: Explorer
    
    var body: some View {
        ScrollView {
            VStack() {
                URLImage(url: URL(string: explorer.photo)!,
                         empty: {
                            EmptyView()
                         },
                         inProgress: { progress in
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                         },
                         failure: { error, retry in
                            Image(systemName: "livephoto.slash")
                                .resizable()
                                .scaledToFit()
                         },
                         content: { image in
                            image
                                .resizable()
                                .scaledToFit()
                         })
                VStack(alignment: .leading) {
                    HStack {
                        ZStack{
                            Image("SpaceBackground")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 90, height: 90)
                            Image(explorer.ship!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60)
                        }
                        Spacer()
                        HStack {
                            Image("TwitterLogo")
                                .resizable()
                                .scaledToFit()
                            Image("InstagramLogo")
                                .resizable()
                                .scaledToFit()
                            Image("LinkedinLogo")
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(height: 40)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(explorer.name)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        ImageOverlay(explorer: explorer, withShift: true)
                        
                        VStack(alignment: .leading) {
                            Text("👨‍🚀 Bio")
                                .font(.title)
                                .fontWeight(.medium)
                                .padding(.bottom, 4)
                            Text(explorer.bio)
                        }
                        .padding()
                        .frame(minHeight: 130)
                        .background(explorer.primaryColor)
                        .cornerRadius(10)
                        .foregroundColor(explorer.secondaryColor)
                        
                        if explorer.skills.count > 0 {
                            VStack(alignment: .leading) {
                                Text("💪 Skills")
                                    .font(.title)
                                    .fontWeight(.medium)
                                    .padding(.bottom, 10)
                                HStack {
                                    TagCloudView(tags: explorer.skills, primaryColor: explorer.primaryColor, secondaryColor: explorer.secondaryColor)
                                        .padding(.all, -5)
                                }
                            }
                            .padding()
                            .background(explorer.primaryColor)
                            .cornerRadius(10)
                            .foregroundColor(explorer.secondaryColor)
                        }
                        
                        if explorer.interest.count > 0 {
                            VStack(alignment: .leading) {
                                Text("🏀 Interest")
                                    .font(.title)
                                    .fontWeight(.medium)
                                    .padding(.bottom, 10)
                                HStack {
                                    TagCloudView(tags: explorer.interest, primaryColor: explorer.primaryColor, secondaryColor: explorer.secondaryColor)
                                        .padding(.all, -5)
                                }
                            }
                            .padding()
                            .background(explorer.primaryColor)
                            .cornerRadius(10)
                            .foregroundColor(explorer.secondaryColor)
                        }
                        
                    }
                }
                .offset(y: -53)
                .padding(.horizontal)
            }
        }
        .navigationTitle("Profile")
    }
}

struct ExplorerDetail_Previews: PreviewProvider {
    static var previews: some View {
        ExplorerDetail(explorer: ModelData().explorers[.random(in: 5...20)])
    }
}
