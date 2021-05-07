//
//  Explore.swift
//  XPlore
//
//  Created by Bryan Khufa on 02/05/21.
//

import SwiftUI

// MARK: - SWIFT UI
struct Explore: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var pauseState: Bool = false
    @State var modalState = false
    @State var showingAlert = false
    
    @State var message: String = ""
    @State var thr: Int = Int(random(min: 10, max: 50))
    @Binding var duit: Int
    
    @State var totalThr = 0
    
    func sendMessage() {
        modalState.toggle()
        showingAlert.toggle()
        NotificationCenter.default.post(name: NSNotification.Name("chat"), object: nil, userInfo: ["message": message])
        
        randomThr()
        totalThr += thr
        print(totalThr)
    }
    
        func randomThr() {
            thr = Int(random(min: 10, max: 50))
        }
    
    var body: some View {
        ZStack {
            Gameplay()
            
            VStack {
                Button(action: {
                    modalState.toggle()
                }){
                    Image(systemName: "message.circle")
                        .font(.largeTitle)
                        .background(Color.white)
                        .clipShape(Circle())
                }.padding(.bottom)
                
                
                //                Button(action: {
                //                    pauseState.toggle()
                //                }){
                //                    Image(systemName: "arrow.clockwise.circle")
                //                        .font(.largeTitle)
                //                        .background(Color.white)
                //                        .clipShape(Circle())
                //                }
            }
            .offset(x: 130, y: 230)
            
            BottomSheet(isOpen: $modalState, maxHeight: 250) {
                VStack(alignment: .leading) {
                    Text("Send Message")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    HStack {
                        TextField("Say something nice ...", text: $message)
                            .padding(5)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(5)
                        
                        Button(action: {
                            sendMessage()
                            //                            print(message)
                        }){
                            Image(systemName: "paperplane.circle")
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        
                    }
                }
                .padding()
            }
            .edgesIgnoringSafeArea(.all)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Message Sent"), message: Text("You just got 🏅\(thr)"), dismissButton: .default(Text("Got it")))
            }
        }
        .onWillDisappear { // << order does NOT matter
            duit += totalThr
            print(duit)
        }
    }
}

//struct Explore_Previews: PreviewProvider {
//    static var previews: some View {
//        Explore()
//    }
//}


