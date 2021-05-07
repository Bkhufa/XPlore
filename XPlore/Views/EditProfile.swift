//
//  EditProfile.swift
//  XPlore
//
//  Created by Bryan Khufa on 05/05/21.
//

import SwiftUI

struct EditProfile: View {
    @Binding var user: Explorer
    @State private var shift = 0
    @State private var skill = ""
    @State private var interest = ""
    
    var shifts = ["🌄 Morning", "🌇 Afternoon", "Mentors"]
    let expertises = ["Tech", "Design", "Domain Expert"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Edit Profile")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Form {
                Section(header: Text("Name")) {
                    TextField(user.name, text: $user.name)
                }
                
                Section(header: Text("Bio")) {
                    TextField(user.bio, text: $user.bio)
                }
                
                Section(header: Text("Academy")) {
                    Picker(selection: $shift, label: Text("Shift")) {
                        ForEach(0 ..< shifts.count) {
                            Text(self.shifts[$0])
                        }
                    }
                    
                    Picker(selection: $shift, label: Text("Expertise")) {
                        ForEach(0 ..< expertises.count) {
                            Text(self.expertises[$0])
                        }
                    }
                }
                
                Section(header: Text("Skills & Interest")) {
                    TextField(arrToStr(stringArray: user.skills), text: $skill)
                    TextField(arrToStr(stringArray: user.interest), text: $interest)
                }
                
                Section(header: Text("Personalization")) {
                    ColorPicker("Set primary color", selection: $user.primaryColor)
                    ColorPicker("Set secondary color", selection: $user.secondaryColor)
                }
                
            }

        }
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile(user: .constant(ModelData().explorers[0]))
    }
}

func arrToStr(stringArray: Array<String>) -> String {
    let string = stringArray.joined(separator: ", ")
    return string
}
