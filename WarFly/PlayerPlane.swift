import SpriteKit

enum TurnDirection {
  case left, right, none
}

class PlayerPlane: SKSpriteNode {
  
  var leftTextureArrayAnimation = [SKTexture]()
  var rightTextureArrayAnimation = [SKTexture]()
  var forwardTextureArrayAnimation = [SKTexture]()
  var screen = UIScreen.main.bounds.size
  var moveDirection: TurnDirection = .none
  var stillTurning = false
  
  static func createPlane(at point: CGPoint) -> PlayerPlane {
    
    let playerPlaneTexture = SKTexture(imageNamed: "airplane_3ver2_13")
    let playerPlane = PlayerPlane(texture: playerPlaneTexture)
    playerPlane.setScale(0.5)
    playerPlane.position = point
    playerPlane.zPosition = 20
    
    return playerPlane
  }
  
  func planeAnimationFillArray() {
    
    SKTextureAtlas.preloadTextureAtlases([SKTextureAtlas(named: "PlayerPlane")]) { [unowned self] in
      
      self.leftTextureArrayAnimation = {
        var array = [SKTexture]()
        for item in stride(from: 13, through: 1, by: -1) {
          let number = String(format: "%02d", item)
          let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
          array.append(texture)
        }
        SKTexture.preload(array) {
          print("preload is done")
        }
        
        return array
        
      }()
      
      self.rightTextureArrayAnimation = {
        var array = [SKTexture]()
        for item in stride(from: 13, through: 26, by: 1) {
          let number = String(format: "%02d", item)
          let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
          array.append(texture)
        }
        SKTexture.preload(array) {
          print("preload is done")
        }
        
        return array
        
      }()
      
      self.forwardTextureArrayAnimation = {
        var array = [SKTexture]()
        let texture = SKTexture(imageNamed: "airplane_3ver2_13")
        array.append(texture)
        
        SKTexture.preload(array) {
          print("preload is done")
        }
        
        return array
        
      }() 
    }
  }
  
  func movementDirectionCheck(at positionX: CGFloat) {
    if
      self.position.x < positionX,
        moveDirection != .right,
        stillTurning == false
    {
      stillTurning = true
      moveDirection = .right
      turnPlane(direction: .right)
    }
    else if
      self.position.x > positionX,
      moveDirection != .left,
      stillTurning == false
    {
      stillTurning = true
      moveDirection = .left
      turnPlane(direction: .left)
    }
    else if stillTurning == false
    {
      turnPlane(direction: .none)
    }
  }
  
  fileprivate func turnPlane(direction: TurnDirection) {
    var array = [SKTexture]()
    
    switch direction {
    case .right:
      array = rightTextureArrayAnimation
    case .left:
      array = leftTextureArrayAnimation
    case .none:
      array = forwardTextureArrayAnimation
    }
    
    let forwardAction = SKAction.animate(with: array,
                                         timePerFrame: 0.05,
                                         resize: true,
                                         restore: false)
    let backwarddAction = SKAction.animate(with: array.reversed(),
                                           timePerFrame: 0.05,
                                           resize: true,
                                           restore: false)
    let sequenceAction = SKAction.sequence([forwardAction, backwarddAction])
    self.run(sequenceAction) { [unowned self] in
      self.stillTurning = false
    }
  }
}
