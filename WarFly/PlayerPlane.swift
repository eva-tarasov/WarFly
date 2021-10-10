import SpriteKit

enum TurnDirection {
  case left, right, none
}

class PlayerPlane: SKSpriteNode {
  
  private var leftTextureArrayAnimation = [SKTexture]()
  private var rightTextureArrayAnimation = [SKTexture]()
  private var forwardTextureArrayAnimation = [SKTexture]()
  private var screen = UIScreen.main.bounds.size
  private var moveDirection: TurnDirection = .none
  private var stillTurning = false
  private let animationSpriteSerialNumber = [(13, 1, -1), (13, 26, 1), (13, 13, 1)]
  
  static func createPlane(at point: CGPoint) -> PlayerPlane {
    
    let playerPlaneTexture = Assets.shared.playerPlaneAtlas.textureNamed("airplane_3ver2_13")
    let playerPlane = PlayerPlane(texture: playerPlaneTexture)
    playerPlane.setScale(0.5)
    playerPlane.position = point
    playerPlane.zPosition = 20
    
    return playerPlane
  }
  
  func preloadTextureArrays() {
    for item in 0...2 {
      self.preloadArray(_stride: animationSpriteSerialNumber[item]) { [unowned self] array in
        switch item {
        case 0: self.leftTextureArrayAnimation = array
        case 1: self.rightTextureArrayAnimation = array
        case 2: self.forwardTextureArrayAnimation = array
        default: break
        }
      }
    }
  }
  
  private func preloadArray(
    _stride: (Int, Int, Int),
    completion: @escaping (_ array: [SKTexture]) -> ()
  ) {
    var array = [SKTexture]()
    for item in stride(from: _stride.0,
                       through: _stride.1,
                       by: _stride.2) {
      let number = String(format: "%02d", item)
      let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
      array.append(texture)
    }
    
    SKTexture.preload(array) {
      completion(array)
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
  
  private func turnPlane(direction: TurnDirection) {
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
