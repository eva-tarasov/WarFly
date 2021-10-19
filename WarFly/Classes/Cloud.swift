import SpriteKit
import GameplayKit

final class Cloud: SKSpriteNode, GameBackgroundSpriteable {
  
  static func createElement(at point: CGPoint?) -> Cloud {
    let cloudImageName = configureName()
    let cloud = Cloud(imageNamed: cloudImageName)
    cloud.setScale(randomScaleFactor)
    cloud.position = point ?? randomPoint()
    cloud.name = "spriteForRemove"
    cloud.anchorPoint = CGPoint(x: 0.5, y: 1) // смещение центра, что бы нод исчезал когда целиком пропадет с экрана
    cloud.zPosition = 10
    cloud.run(move(from: cloud.position))
    
    return cloud
  }
  
  // устанавливаем рэндомное имя изображения облака
  private static func configureName() -> String {
    let distribution = GKRandomDistribution(lowestValue: 1,
                                            highestValue: 3)
    let randomNumber = distribution.nextInt()
    
    return "cl\(randomNumber)"
  }
  
  // устанавливаем рэндомное число для размера облака
  private static var randomScaleFactor: CGFloat {
    let distribution = GKRandomDistribution(lowestValue: 15,
                                            highestValue: 20)
    let randomNumber = CGFloat(distribution.nextInt()) / 10
    
    return randomNumber
  }
  
  // Настройки движения объекта
  private static func move(from point: CGPoint) -> SKAction {
    let movePoint = CGPoint(x: point.x, y: -200)
    let moveDistance = point.x + 200
    let movementSpeed: CGFloat = 40.0
    let duration = moveDistance / movementSpeed
    
    return SKAction.move(to: movePoint, duration: TimeInterval(duration))
  }
}
