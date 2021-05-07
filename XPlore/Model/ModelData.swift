//
//  ModelData.swift
//  XPlore
//
//  Created by Bryan Khufa on 02/05/21.
//

import Foundation
import Combine
import SwiftUI

final class ModelData: ObservableObject {
    @Published var explorers: [Explorer] = load("explorerData.json")
    @Published var spaceships: [Spaceship] = load("spaceShip.json")
    @State var duit = 0
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
