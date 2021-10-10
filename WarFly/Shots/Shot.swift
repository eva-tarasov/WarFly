
import SpriteKit

class Shot: SKSpriteNode {
  private let screen = UIScreen.main.bounds
  private let initialSize = CGSize(width: 187, height: 237)
  private let textureAtlas: SKTextureAtlas!
  private var textureNameBegin = ""
  private var animationSpriteArray = [SKTexture]()
  
  init(textureAtlas: SKTextureAtlas) {
    self.textureAtlas = textureAtlas
    let textureName = textureAtlas.textureNames.sorted()[0]
    let texture = textureAtlas.textureNamed(textureName)
    textureNameBegin = String(textureName.dropLast(6))
    super.init(texture: texture, color: .clear, size: initialSize)
    self.setScale(0.3)
    self.name = "spriteForShot"
    self.zPosition = 30
    
    self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
    self.physicsBody?.isDynamic = false
    self.physicsBody?.categoryBitMask = BitMaskCategory.shot.rawValue
    self.physicsBody?.collisionBitMask = BitMaskCategory.enemy.rawValue
    self.physicsBody?.contactTestBitMask = BitMaskCategory.enemy.rawValue
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func startMovement() {
    performRotation()
    
    let moveForvard = SKAction.moveTo(y: screen.size.height + 100, duration: 2)
    self.run(moveForvard)
  }
  
  private func performRotation() {
    for item in 1...32 {
      let number = String(format: "%02d", item)
      animationSpriteArray.append(SKTexture(imageNamed: textureNameBegin + number.description))
    }
    
    SKTexture.preload(animationSpriteArray) { [unowned self] in
      let rotation = SKAction.animate(with: self.animationSpriteArray,
                                      timePerFrame: 0.05,
                                      resize: true,
                                      restore: false)
      let rotationForever = SKAction.repeatForever(rotation)
      self.run(rotationForever)
    }
  }
}
