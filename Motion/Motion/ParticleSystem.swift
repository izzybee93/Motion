//
//  ParticleSystem.swift
//  Motion
//
//  Created by Isabel Briant on 08/02/2022.
//

import SwiftUI

final class ParticleSystem {
    let image = Image("spark")
    var particles = Set<Particle>()
    var center = UnitPoint.center
    var hue = 0.0

    func update(date: TimeInterval) {
        let deathDate = date - 1 // keep particles alive for 1 second
        for particle in particles {
            if particle.creationDate < deathDate {
                particles.remove(particle)
            }
        }
        let newParticle = Particle(x: center.x, y: center.y, hue: hue)
        particles.insert(newParticle)
        hue += 0.01
        if hue > 1 {
            hue = 0.01 // hue is red at 0 and 1 so will smoothly loop around
        }
    }
}
