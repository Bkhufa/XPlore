//
//  ExplorerCard.swift
//  XPlore
//
//  Created by Bryan Khufa on 01/05/21.
//

import SwiftUI
import URLImage

struct ExplorerCard: View {
    let explorer: Explorer
    
    var body: some View {
        VStack(alignment: .leading) {
            URLImage(url: URL(string: explorer.photo)!,
                     empty: {
                        EmptyView()
                     },
                     inProgress: { progress in
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .overlay(ImageOverlay(explorer: explorer, withShift: false), alignment: .topTrailing)
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
                            .overlay(ImageOverlay(explorer: explorer, withShift: false).padding(5), alignment: .topTrailing)
                     })
            HStack {
                ZStack{
                    Image("SpaceBackground")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 50, height: 50)
                    Image(explorer.ship!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35)
                }
                Text(explorer.name)
                    .font(.callout)
                    .lineLimit(2)
                    .foregroundColor(explorer.secondaryColor)
            }
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 10, trailing: 5))
        }
        .background(explorer.primaryColor)
        .cornerRadius(10)
    }
}

struct ExplorerCard_Previews: PreviewProvider {
    static var previews: some View {
        ExplorerCard(explorer: ModelData().explorers[0])
    }
}
