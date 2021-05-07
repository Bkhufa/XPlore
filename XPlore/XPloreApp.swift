//
//  XPloreApp.swift
//  XPlore
//
//  Created by Bryan Khufa on 30/04/21.
//

import SwiftUI

@main
struct XPloreApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
