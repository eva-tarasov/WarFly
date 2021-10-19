import SpriteKit
import GameplayKit

final class Island: SKSpriteNode, GameBackgroundSpriteable {
  
  static func createElement(at point: CGPoint?) -> Island {
    let islandImageName = configureName()
    let island = Island(imageNamed: islandImageName)
    island.setScale(randomScaleFactor)
    island.position = point ?? randomPoint()
    island.name = "spriteForRemove"
    island.anchorPoint = CGPoint(x: 0.5, y: 1) // смещение центра, что бы нод исчезал когда целиком пропадет с экрана
    island.zPosition = 2
    island.run(rotateForRandomAngle())
    island.run(move(from: island.position))
    
    return island
  }
  
  // устанавливаем рэндомное имя изображения острова
  fileprivate static func configureName() -> String {
    let distribution = GKRandomDistribution(lowestValue: 1,
                                            highestValue: 4)
    let randomNumber = distribution.nextInt()
    
    return "is\(randomNumber)"
  }
  
  // устанавливаем рэндомное число для размера острова
  fileprivate static var randomScaleFactor: CGFloat {
    let distribution = GKRandomDistribution(lowestValue: 1,
                                            highestValue: 10)
    let randomNumber = CGFloat(distribution.nextInt()) / 10
    
    return randomNumber
  }
  
  // устанавливаем рэндомный угол на который будет повернут остров
  fileprivate static func rotateForRandomAngle() -> SKAction {
    let distribution = GKRandomDistribution(lowestValue: 0,
                                            highestValue: 360)
    let randomNumber = CGFloat(distribution.nextInt())
    
    return SKAction.rotate(
      toAngle: randomNumber * CGFloat(Double.pi / 180),
      duration: 0
    )
  }
  
  // Настройки движения объекта
  fileprivate static func move(from point: CGPoint) -> SKAction {
    let movePoint = CGPoint(x: point.x, y: -200)
//    let moveDistance = point.x + 200
//    let movementSpeed: CGFloat = 30.0
//    let duration = moveDistance / movementSpeed
    
    return SKAction.move(to: movePoint, duration: 10)
  }
}
