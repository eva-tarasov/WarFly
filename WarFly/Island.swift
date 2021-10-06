//
//  Island.swift
//  WarFly
//
//  Created by Evgeny Tarasov on 06.10.2021.
//

import SpriteKit
import GameplayKit

class Island: SKSpriteNode {
    
    static func createIsland(at point: CGPoint) -> Island {
        let islandImageName = configureIslandName()
        let island = Island(imageNamed: islandImageName)
        island.setScale(randomScaleFactor)
        island.position = point
        island.zPosition = 2
        island.run(rotateForRandomAngle())
        
        return island
    }
    
    // устанавливаем рэндомное имя изображения острова
    static func configureIslandName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1,
                                                highestValue: 4)
        let randomNumber = distribution.nextInt()
        
        return "is\(randomNumber)"
    }
    
    // устанавливаем рэндомное число для размера острова
    static var randomScaleFactor: CGFloat {
        let distribution = GKRandomDistribution(lowestValue: 1,
                                                highestValue: 10)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
    
    // устанавливаем рэндомный угол на который будет повернут остров
    static func rotateForRandomAngle() -> SKAction {
        let distribution = GKRandomDistribution(lowestValue: 0,
                                                highestValue: 360)
        let randomNumber = CGFloat(distribution.nextInt())
        
        return SKAction.rotate(
            toAngle: randomNumber * CGFloat(Double.pi / 180),
            duration: 0
        )
    }
}
