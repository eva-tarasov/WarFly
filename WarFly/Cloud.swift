//
//  Cloud.swift
//  WarFly
//
//  Created by Evgeny Tarasov on 06.10.2021.
//

import SpriteKit
import GameplayKit

final class Cloud: SKSpriteNode, GameBackgroundSpriteable {
    
    static func createElement(at point: CGPoint) -> Cloud {
        let cloudImageName = configureName()
        let cloud = Cloud(imageNamed: cloudImageName)
        cloud.setScale(randomScaleFactor)
        cloud.position = point
        cloud.zPosition = 10
        
        return cloud
    }
    
    // устанавливаем рэндомное имя изображения облака
    fileprivate static func configureName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1,
                                                highestValue: 3)
        let randomNumber = distribution.nextInt()
        
        return "cl\(randomNumber)"
    }
    
    // устанавливаем рэндомное число для размера облака
    fileprivate static var randomScaleFactor: CGFloat {
        let distribution = GKRandomDistribution(lowestValue: 20,
                                                highestValue: 30)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
}
