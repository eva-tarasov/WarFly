import UIKit
import SpriteKit

class PowerUp: SKSpriteNode {
  private let initialSize = CGSize(width: 52, height: 52)
  private let textureAtlas: SKTextureAtlas!
  private var textureNameBegin = ""
  private var animationSpriteArray = [SKTexture]()
  
  init(textureAtlas: SKTextureAtlas) {
    self.textureAtlas = textureAtlas
    let textureName = textureAtlas.textureNames.sorted()[0]
    let texture = textureAtlas.textureNamed(textureName)
    textureNameBegin = String(textureName.dropLast(6))
    super.init(texture: texture, color: .clear, size: initialSize)
    self.setScale(0.6)
    self.name = "spriteForRemove"
    self.zPosition = 20
    
    self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
    self.physicsBody?.isDynamic = true
    self.physicsBody?.categoryBitMask = BitMaskCategory.powerUp.rawValue
    self.physicsBody?.collisionBitMask = BitMaskCategory.player.rawValue
    self.physicsBody?.contactTestBitMask = BitMaskCategory.player.rawValue
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func startMovement() {
    performRotation()
    
    let moveForvard = SKAction.moveTo(y: -110, duration: 5)
    self.run(moveForvard)
  }
  
  private func performRotation() {
    for item in 1...15 {
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
