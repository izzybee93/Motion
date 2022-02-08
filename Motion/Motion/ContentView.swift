//
//  ContentView.swift
//  Motion
//
//  Created by Isabel Briant on 08/02/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var particleSystem = ParticleSystem() // @State for a class here (not @StateObject because it is not an observable object, its simply a cache for the particles
    @State private var motionHandler = MotionManager()

    let options: [(flipX: Bool, flipY: Bool)] = [
        (false, false),
        (true, false),
        (false, true),
        (true, true)
    ]

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                particleSystem.update(date: timelineDate)

                context.blendMode = .plusLighter
//                context.addFilter(.colorMultiply(.green)) // filter is not removable over time, so create a copy of context to adjust the colour (struct so value type)

                particleSystem.center = UnitPoint(x: motionHandler.roll + 0.5, y: motionHandler.pitch + 0.5)

                for particle in particleSystem.particles {

                    var contextCopy = context
                    contextCopy.addFilter(.colorMultiply(Color(hue: particle.hue, saturation: 1, brightness: 1)))
                    contextCopy.opacity = 1 - (timelineDate - particle.creationDate)

//                    for option in options {
                        var xPosition = particle.x * size.width
                        var yPosition = particle.y * size.height
//
//                        if option.flipX {
//                            xPosition = size.width - xPosition
//                        }
//                        if option.flipY  {
//                            yPosition = size.height - yPosition
//                        }
                        contextCopy.draw(particleSystem.image, at: CGPoint(x: xPosition, y: yPosition))
//                    }
                }
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    particleSystem.center.x = value.location.x / UIScreen.main.bounds.width // convert x position from scale 0-1
                    particleSystem.center.y = value.location.y / UIScreen.main.bounds.height // convert y position from scale 0-1
                })
        .ignoresSafeArea()
        .background(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
