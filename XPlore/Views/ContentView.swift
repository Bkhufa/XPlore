//
//  ContentView.swift
//  XPlore
//
//  Created by Bryan Khufa on 30/04/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        TabView {
            Browse()
                .tabItem {
                    Label("Browse", systemImage: "magnifyingglass")
                }
            Explore(duit: $modelData.explorers[0].point)
                .tabItem {
                    Label("Explore", systemImage: "binoculars")
                }
            Profile()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
