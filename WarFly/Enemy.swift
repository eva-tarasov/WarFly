
import SpriteKit

enum EnemyDirection: Int {
  case left = 0
  case right
}

class Enemy: SKSpriteNode {
  private let initialSize = CGSize(width: 221, height: 204)
  private var enemyTexture: SKTexture!
  
  static var textureAtlas: SKTextureAtlas?
  
  init(enemyTexture: SKTexture) {
    let texture = enemyTexture
    super.init(texture: texture, color: .clear, size: initialSize)
    self.xScale = 0.5
    self.yScale = -0.5
    self.zPosition = 19
    self.name = "spriteForRemove"
    
    self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
    self.physicsBody?.isDynamic = true
    self.physicsBody?.categoryBitMask = BitMaskCategory.enemy
    self.physicsBody?.collisionBitMask = BitMaskCategory.player | BitMaskCategory.shot
    self.physicsBody?.contactTestBitMask = BitMaskCategory.player | BitMaskCategory.shot
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func flySpiral() {
    let screenSize = UIScreen.main.bounds
    let timeHorizontal: Double = 3
    let timeVertical: Double = 7
    let moveLeft = SKAction.moveTo(x: 50, duration: timeHorizontal)
    moveLeft.timingMode = .easeInEaseOut
    let moveRight = SKAction.moveTo(x: screenSize.width - 50, duration: timeHorizontal)
    moveRight.timingMode = .easeInEaseOut
    
    let randomNumber = Int(arc4random_uniform(2)) // выбор рэндомного числа 1 или 0 (2 не входит)
    let movementSequence =
    randomNumber == EnemyDirection.left.rawValue ?
    SKAction.sequence([moveLeft, moveRight]) :
    SKAction.sequence([moveRight, moveLeft])

    let foreverMovement = SKAction.repeatForever(movementSequence)
    
    let bottomMovement = SKAction.moveTo(y: -105, duration: timeVertical)
    let groupMovement = SKAction.group([foreverMovement, bottomMovement])
    self.run(groupMovement)
  }
}
