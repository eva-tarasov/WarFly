//
//  GameScene.swift
//  WarFly
//
//  Created by Evgeny Tarasov on 06.10.2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
     
    override func didMove(to view: SKView) {
        
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = Background.populateBackground(at: screenCenterPoint)
        // что бы растянуть фон на все устройства
        background.size = self.size
        
        self.addChild(background)
    }
    
}
