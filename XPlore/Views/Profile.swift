//
//  Profile.swift
//  XPlore
//
//  Created by Bryan Khufa on 02/05/21.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var modelData: ModelData
    @State private var modalState = false
    @State private var modalEdit = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ExplorerDetail(explorer: modelData.explorers[0])
                    .navigationTitle("Your Profile")
                    .navigationBarItems(
                        leading:
                            Button("🏅\(modelData.explorers[0].point)") {
                                self.modalState.toggle()
                            },
                        trailing:
                            Button("Edit") {
                                modalEdit.toggle()
                            }.sheet(isPresented: $modalEdit) {
                                EditProfile(user: $modelData.explorers[0])
                            }
                    )
                
                BottomSheet(isOpen: $modalState, maxHeight: ScreenSize.height * 0.65) {
                    Shop()
                }.edgesIgnoringSafeArea(.all)
                
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
            .environmentObject(ModelData())
    }
}
