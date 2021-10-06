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
        
        
        let screen = UIScreen.main.bounds
        
        // TODO: сделать проверку на наложение
        for _ in 1...6 {
            let x = CGFloat(GKRandomSource
                                .sharedRandom()
                                .nextInt(
                                    upperBound: Int(screen.size.width)
                                ))
            let y = CGFloat(GKRandomSource
                                .sharedRandom()
                                .nextInt(
                                    upperBound: Int(screen.size.height)
                                ))
            
            let island = Island.createElement(at: CGPoint(x: x, y: y))
            
            self.addChild(island)
        }
        
        for _ in 1...4 {
            let x = CGFloat(GKRandomSource
                                .sharedRandom()
                                .nextInt(
                                    upperBound: Int(screen.size.width)
                                ))
            let y = CGFloat(GKRandomSource
                                .sharedRandom()
                                .nextInt(
                                    upperBound: Int(screen.size.height)
                                ))
            
            let cloud = Cloud.createElement(at: CGPoint(x: x, y: y))
            
            self.addChild(cloud)
        }
    }
    
}
