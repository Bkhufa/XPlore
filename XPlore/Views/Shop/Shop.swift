//
//  Shop.swift
//  XPlore
//
//  Created by Bryan Khufa on 04/05/21.
//

import SwiftUI
import ACarousel

struct Shop: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Shop")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)
            ACarousel(modelData.spaceships, id: \.self,
                      spacing: 70,
                      headspace: 40,
                      sidesScaling: 0.8,
                      isWrap: true
            ) { item in
                VStack (alignment: .center) {
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(30)
                    
                    Text(item.name)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                    
                    Text("🏅\(item.price)")
                        .font(.title2)
                        .padding(.bottom)
                    
                    PurchaseButton(user: $modelData.explorers[0], ship: item)
                    
                }
            }
            .frame(height: 300)

        }
    }
}

struct Shop_Previews: PreviewProvider {
    static var previews: some View {
        Shop()
    }
}
