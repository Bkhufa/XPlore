//
//  Explorer.swift
//  XPlore
//
//  Created by Bryan Khufa on 01/05/21.
//

import Foundation
import SwiftUI

struct Explorer: Hashable, Codable {
    var name: String
    var photo: String
    var expertise: Expertise
    var team: String
    var shift: Shift
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case photo = "Photo"
        case expertise = "Expertise"
        case team = "Team"
        case shift = "Shift"
    }
    
    var interest = ["Music", "Space", "Philosophy", "Politics", "Religion", "Movies", "Tech", "Education", "Nature", "Finance", "Health", "Sports", "Animals", "Automotive", "Cooking", "Fitness"].pick(.random(in: 2...6))
    var skills = ["Public speaking", "Illustration", "Software developments", "Business", "Marketing", "Consulting", "Investing", "Content management", "Graphic Design", "Animation", "FrontEnd", "BackEnd", "Research"].pick(.random(in: 2...6))
    var bio = "I am a junior software engineer who love to learn new stuffs and create networking"
    
    var primaryColor = randomColor(isDark: true)
    var secondaryColor = randomColor(isDark: false)
    var ship = ["Ship0", "Ship2", "Ship3", "Ship4", "Ship5", "Ship6", "Ship7", "Ship8", "Ship9", "Ship10", "Ship11"].randomElement()
    
    var point = 400
    var coordX = random() * 5000
    var coordY = random() * 5000
}

enum Expertise: String, Codable {
    case design = "Design"
    case domainExpertKeahlianKhusus = "Domain Expert (Keahlian Khusus)"
    case techITIS = "Tech / IT / IS"
}

enum Shift: String, Codable {
    case afternoon = "Afternoon"
    case morning = "Morning"
    case morningAfternoon = "Morning,Afternoon"
}

extension Array {
    func pick(_ n: Int) -> [Element] {
        guard count >= n else {
            fatalError("The count has to be at least \(n)")
        }
        guard n >= 0 else {
            fatalError("The number of elements to be picked must be positive")
        }

        let shuffledIndices = indices.shuffled().prefix(upTo: n)
        return shuffledIndices.map {self[$0]}
    }
}
