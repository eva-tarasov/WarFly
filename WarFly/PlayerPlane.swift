import SpriteKit

class PlayerPlane: SKSpriteNode {
  
  var leftTextureArrayAnimation = [SKTexture]()
  var rightTextureArrayAnimation = [SKTexture]()
  var forwardTextureArrayAnimation = [SKTexture]()
  
  static func createPlane(at point: CGPoint) -> PlayerPlane {
    
    let playerPlaneTexture = SKTexture(imageNamed: "airplane_3ver2_13")
    let playerPlane = PlayerPlane(texture: playerPlaneTexture)
    playerPlane.setScale(0.5)
    playerPlane.position = point
    playerPlane.zPosition = 20
    
    return playerPlane
  }
}
