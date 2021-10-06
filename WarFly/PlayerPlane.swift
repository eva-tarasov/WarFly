//
//  PlayerPlane.swift
//  WarFly
//
//  Created by Evgeny Tarasov on 06.10.2021.
//

import SpriteKit

class PlayerPlane: SKSpriteNode {
    
    static func createPlane(at point: CGPoint) -> SKSpriteNode {
        
        let playerPlaneTexture = SKTexture(imageNamed: "airplane_3ver2_13")
        let playerPlane = SKSpriteNode(texture: playerPlaneTexture)
        playerPlane.setScale(0.5)
        playerPlane.position = point
        playerPlane.zPosition = 20
        
        return playerPlane
    }
}
