//
//  Utils.swift
//  XPlore
//
//  Created by Bryan Khufa on 02/05/21.
//

import Foundation
import SwiftUI

func getExpertiseIcon(expertise: Expertise) -> Image {
    switch expertise {
    case .design:
        return Image(systemName: "paintpalette")
    case .techITIS:
        return Image(systemName: "chevron.left.slash.chevron.right")
    case.domainExpertKeahlianKhusus:
        return Image(systemName: "person.2")
    }
}

func getExpertiseText(expertise: Expertise) -> Text {
    switch expertise {
    case .design:
        return Text("Design")
    case .techITIS:
        return Text("Tech")
    case.domainExpertKeahlianKhusus:
        return Text("Domain Expert")
    }
}

func getShiftIcon(shift: Shift) -> Text {
    switch shift {
    case .morning:
        return Text("🌄 Morning")
    case .afternoon:
        return Text("🌇 Afternoon")
    case .morningAfternoon:
        return Text("Mentors")
    }
}

func randomColor(isDark: Bool) -> Color {
    if isDark {
        return Color(
            red: .random(in: 0...0.45),
            green: .random(in: 0...0.45),
            blue: .random(in: 0...0.45)
        )
    } else {
        return Color(
            red: .random(in: 0.55...1),
            green: .random(in: 0.55...1),
            blue: .random(in: 0.55...1)
        )
    }
}

func random() -> CGFloat {
  return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}

func random(min: CGFloat, max: CGFloat) -> CGFloat {
  return random() * (max - min) + min
}

func randomCoords() -> CGPoint {
    let coord = CGPoint(x: random() * 5000, y: random() * 5000)
    return coord
}


func randomCoords(min: CGFloat, max: CGFloat) -> CGPoint {
    let coord = CGPoint(x: random(min: min, max: max), y: random(min: min, max: max))
    return coord
}
