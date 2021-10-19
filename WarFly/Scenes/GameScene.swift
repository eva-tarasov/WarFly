import SpriteKit
import GameplayKit

class GameScene: SKScene {
  
  private var playerPlane: PlayerPlane!
  private var enemy: Enemy!
  
  private var oneTapGuesture = UITapGestureRecognizer()
  
  private let hud = HUD()
  private let screenSize = UIScreen.main.bounds.size
  
  private func distanceCalculation(a: CGPoint, b: CGPoint) -> CGFloat {
    return sqrt((b.x - a.x) * (b.x - a.x) + (b.y - a.y) * (b.y - a.y))
  }
  
  // Генерируем Облака
  private func spawnCloud() {
    let spawnCloudWait = SKAction.wait(forDuration: 1)
    let spawnCloudAction = SKAction.run { [unowned self] in
      let cloud = Cloud.createElement(at: nil)
      self.addChild(cloud)
    }
    let spawnCloudSequence = SKAction.sequence([spawnCloudWait, spawnCloudAction])
    let spawnCloudForever = SKAction.repeatForever(spawnCloudSequence)
    
    run(spawnCloudForever)
  }
  
  // Генерируем острова
  private func spawnIsland() {
    let spawnIslandWait = SKAction.wait(forDuration: 2)
    let spawnIslandAction = SKAction.run { [unowned self] in
      let island = Island.createElement(at: nil)
      self.addChild(island)
    }
    let spawnIslandSequence = SKAction.sequence([spawnIslandWait, spawnIslandAction])
    let spawnIslandForever = SKAction.repeatForever(spawnIslandSequence)
    
    run(spawnIslandForever)
  }
  
  private func configureStartScene() {
    let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
    let background = Background.populateBackground(at: screenCenterPoint)
    // что бы растянуть фон на все устройства
    background.size = self.size
    
    self.addChild(background)
    
    
    // TODO: посмотреть, где еще будет использоваться (может вынести из didMove)
    let screen = UIScreen.main.bounds
    
    // TODO: сделать проверку на наложение
    
    playerPlane = PlayerPlane.createPlane(at: CGPoint(x: screen.size.width / 2, y: 100))
    
    self.addChild(playerPlane)
  }
  
  private func spawnPowerUp() {
    
    let spawnAction = SKAction.run { [unowned self] in
      let randomNumber = Int(arc4random_uniform(2))
      let powerUp = randomNumber == 1 ? BluePowerUp() : GreenPowerUp()
      let randomPositionX = arc4random_uniform(UInt32(self.size.width - 30))
      
      powerUp.position = CGPoint(x: CGFloat(randomPositionX), y: self.size.height + 100)
      powerUp.startMovement()
      
      self.addChild(powerUp)
    }
    
    let randomTimeSpawn = Double(arc4random_uniform(11) + 10)
    let waitAction = SKAction.wait(forDuration: randomTimeSpawn)
    let sequenceAction = SKAction.sequence([waitAction, spawnAction])
    let repeatAction = SKAction.repeatForever(sequenceAction)
    
    self.run(repeatAction)
  }
  
  private func generateSpiralOfEnemy() {
    let enemyTextureAtlas1 = Assets.shared.enemy_1Atlas
    let enemyTextureAtlas2 = Assets.shared.enemy_2Atlas
    SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas1, enemyTextureAtlas2]) { [unowned self] in
      
      let randomNumber = Int(arc4random_uniform(2))
      let arrayOfAtlasses = [enemyTextureAtlas1, enemyTextureAtlas2]
      let textureAtlases = arrayOfAtlasses[randomNumber]
      
      let waitAction = SKAction.wait(forDuration: 3)
      let spawnEnemy = SKAction.run { [unowned self] in
        let textureNames = textureAtlases.textureNames.sorted()
        let texture = textureAtlases.textureNamed(textureNames[12]) // достаем имя текстуры, сначала обращаемся к массиву текстур (textureNamed), потом к конкретной текстуре (textureNames)
        
        self.enemy = Enemy(enemyTexture: texture)
        self.enemy.position = CGPoint(
          x: self.size.width / 2,
          y: self.size.height + 110
        )
        self.enemy.flySpiral()
        self.addChild(self.enemy)
      }
      let sequenceAction = SKAction.sequence([waitAction, spawnEnemy])
      let repeatAction = SKAction.repeat(sequenceAction, count: 3)
      self.run(repeatAction)
    }
  }
  
  private func spawnEnemies() {
    let waitAction = SKAction.wait(forDuration: 4.0)
    let genirateSpiralEnemy = SKAction.run { [unowned self] in
      self.generateSpiralOfEnemy()
    }
    let sequenceAction = SKAction.sequence([waitAction, genirateSpiralEnemy])
    let repeatAction = SKAction.repeatForever(sequenceAction)
    self.run(repeatAction)
  }
  
  private func setUpGestureHandlers() {
    
    oneTapGuesture.addTarget(self, action: #selector(oneTap(_:)))
    view?.addGestureRecognizer(oneTapGuesture)
  }
  
  @objc private func oneTap(_ gestureRecognizer: UITapGestureRecognizer) {
    let shot = YellowShot()
    shot.position = self.playerPlane.position
    shot.startMovement()
    self.addChild(shot)
  }
  
  private func createHUD() {
    hud.configureUI(screenSize: screenSize)
    addChild(hud)
  }
  
  override func didMove(to view: SKView) {
    
    configureStartScene()
    createHUD()
    playerPlane.preloadTextureArrays()
    spawnIsland()
    spawnCloud()
    
    spawnPowerUp()
    
    spawnEnemies()
    
    setUpGestureHandlers()
    
    physicsWorld.contactDelegate = self
    physicsWorld.gravity = CGVector.zero
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    if let touch = touches.first {

      let touchLocation = touch.location(in: self)
      let distance = distanceCalculation(a: playerPlane.position, b: touchLocation)
      let speed: CGFloat = 500
      let timeToDistance = TimeInterval(distance / speed)

      let moveAction = SKAction.move(to: CGPoint(x: touchLocation.x, y: 100), duration: timeToDistance)
      playerPlane.run(moveAction)

      playerPlane.movementDirectionCheck(at: touchLocation.x)
    }
  }
  
  override func didSimulatePhysics() {
    
    // Убираем ноды когда они исчезают с экрана по оси Y
    enumerateChildNodes(withName: "spriteForRemove") { node, stop in
      if node.position.y <= -100 {
        node.removeFromParent()
//        if node.isKind(of: PowerUp.self) {
//          print("PowerUp is removed from scene")
//        }
      }
    }
    
    enumerateChildNodes(withName: "spriteForShot") { [weak self] node, _ in
      guard let self = self else { return }
      if node.position.y >= self.size.height + 100 {
        node.removeFromParent()
      }
    }
    
  }
  
}

extension GameScene: SKPhysicsContactDelegate {
  func didBegin(_ contact: SKPhysicsContact) {
    
    let explosion = SKEmitterNode(fileNamed: "EnemyExplosion")
    let contactPointWithEnemy = contact.contactPoint
    explosion?.position = contactPointWithEnemy
    explosion?.zPosition = 25
    let waitForExplosionAction = SKAction.wait(forDuration: 1)
    
    let contactCategory: BitMaskCategory = [contact.bodyA.category, contact.bodyB.category]
    switch contactCategory {
    case [.enemy, .player]:
      print("enemy vs player")
      if contact.bodyA.node?.name == "spriteForRemove" {
        contact.bodyA.node?.removeFromParent()
      } else {
        contact.bodyB.node?.removeFromParent()
      }
      
      if let explosion = explosion {
        addChild(explosion)
        self.run(waitForExplosionAction) {
          explosion.removeFromParent()
        }
      }
      
    case [.player, .powerUp]: print("player vs powerUp")
    case [.shot, .enemy]:
      print("enemy vs shot")
      contact.bodyA.node?.removeFromParent()
      contact.bodyB.node?.removeFromParent()
      
      if let explosion = explosion {
        addChild(explosion)
        self.run(waitForExplosionAction) {
          explosion.removeFromParent()
        }
      }
    default: preconditionFailure("Unable to detect collision category")
    }
  }
  
  func didEnd(_ contact: SKPhysicsContact) {
    
  }
}