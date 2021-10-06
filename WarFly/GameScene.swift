//
//  GameScene.swift
//  WarFly
//
//  Created by Evgeny Tarasov on 06.10.2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var playerPlane: SKSpriteNode!
     
    override func didMove(to view: SKView) {
        
        configureStartScene()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            let touchLocation = touch.location(in: self)
            let distance = distanceCalculation(a: playerPlane.position, b: touchLocation)
            let speed: CGFloat = 500
            let timeToDistance = TimeInterval(distance / speed)
            
            let moveAction = SKAction.move(to: CGPoint(x: touchLocation.x, y: 100), duration: timeToDistance)
            playerPlane.run(moveAction)
        }
    }
    
    fileprivate func distanceCalculation(a: CGPoint, b: CGPoint) -> CGFloat {
        return sqrt((b.x - a.x) * (b.x - a.x) + (b.y - a.y) * (b.y - a.y))
    }
    
    fileprivate func configureStartScene() {
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = Background.populateBackground(at: screenCenterPoint)
        // что бы растянуть фон на все устройства
        background.size = self.size
        
        self.addChild(background)
        
        
        // TODO: посмотреть, где еще будет использоваться (может вынести из didMove)
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
        
        playerPlane = PlayerPlane.createPlane(at: CGPoint(x: screen.size.width / 2, y: 100))
        
        self.addChild(playerPlane)
    }
    
}
