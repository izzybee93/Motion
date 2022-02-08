//
//  Particle.swift
//  Motion
//
//  Created by Isabel Briant on 08/02/2022.
//

import Foundation

struct Particle: Hashable {
    let x: Double
    let y: Double
    let creationDate = Date.now.timeIntervalSinceReferenceDate
    let hue: Double
}
