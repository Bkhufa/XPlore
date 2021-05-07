//
//  PurchaseButton.swift
//  XPlore
//
//  Created by Bryan Khufa on 04/05/21.
//

import SwiftUI

struct PurchaseButton: View {
    @Binding var user: Explorer
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertText = ""
    @State private var isPurchased = false
    
    let ship: Spaceship
    
    var body: some View {
        Button(user.ship == ship.image ? "Equipped" : "Purchase") {
            if ship.image == user.ship {
                alertTitle = "Ship Already Owned"
                alertText = ""
            }
            else if ship.price > user.point {
                alertTitle = "Purchase Failed"
                alertText = "Insufficent Points!"
            }
            else {
                user.point = user.point - ship.price
                user.ship = ship.image
                alertTitle = "Purchase Successful"
                alertText = "\(ship.name) Successfully purchased and equipped"
            }
            showingAlert = true
        }
        .padding(10)
        .background(user.ship == ship.image ? Color.green : Color.yellow )
        .foregroundColor(Color.black)
        .cornerRadius(10)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertText), dismissButton: .default(Text("Thank you")))
        }
    }
}

struct PurchaseButton_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseButton(user: .constant(ModelData().explorers[0]), ship: ModelData().spaceships[0])
    }
}

func purchaseShip(ship: Spaceship, user: Explorer = ModelData().explorers[0]) -> Int {
    
    return 0
}
