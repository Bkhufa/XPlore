//
//  ImageOverlay.swift
//  XPlore
//
//  Created by Bryan Khufa on 02/05/21.
//

import SwiftUI

struct ImageOverlay: View {
    var explorer: Explorer
    var withShift: Bool
    
    var body: some View {
        ZStack {
            HStack {
                if withShift {
                    getShiftIcon(shift: explorer.shift)
                        .padding(8)
                        .background(explorer.secondaryColor)
                        .foregroundColor(explorer.primaryColor)
                        .cornerRadius(50.0)
                    
                    HStack{
                        getExpertiseIcon(expertise: explorer.expertise)
                        getExpertiseText(expertise: explorer.expertise)
                    }
                    .padding(8)
                    .background(explorer.secondaryColor)
                    .foregroundColor(explorer.primaryColor)
                    .cornerRadius(50.0)
                    Spacer()
                } else {
                    getExpertiseIcon(expertise: explorer.expertise)
                        .font(.system(size: 15))
                        .frame(width: 30, height: 30)
                        .background(explorer.secondaryColor)
                        .foregroundColor(explorer.primaryColor)
                        .cornerRadius(50.0)
                        .shadow(color: explorer.primaryColor, radius: 5)
                }
            }
        }
    }
}

struct ImageOverlay_Previews: PreviewProvider {
    static var previews: some View {
        ImageOverlay(explorer: ModelData().explorers[0], withShift: true)
    }
}
