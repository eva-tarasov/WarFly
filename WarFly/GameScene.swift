import SpriteKit
import GameplayKit

class GameScene: SKScene {
  
  var playerPlane: PlayerPlane!
  var powerUp: PowerUp!
  var enemy: Enemy!
  
  fileprivate func distanceCalculation(a: CGPoint, b: CGPoint) -> CGFloat {
    return sqrt((b.x - a.x) * (b.x - a.x) + (b.y - a.y) * (b.y - a.y))
  }
  
  // Генерируем Облака
  fileprivate func spawnCloud() {
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
  fileprivate func spawnIsland() {
    let spawnIslandWait = SKAction.wait(forDuration: 2)
    let spawnIslandAction = SKAction.run { [unowned self] in
      let island = Island.createElement(at: nil)
      self.addChild(island)
    }
    let spawnIslandSequence = SKAction.sequence([spawnIslandWait, spawnIslandAction])
    let spawnIslandForever = SKAction.repeatForever(spawnIslandSequence)
    
    run(spawnIslandForever)
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
    
    playerPlane = PlayerPlane.createPlane(at: CGPoint(x: screen.size.width / 2, y: 100))
    
    self.addChild(playerPlane)
  }
  
  fileprivate func spawnPowerUp() {
    powerUp = PowerUp()
    powerUp.performRotation()
    powerUp.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
    self.addChild(powerUp)
  }
  
  fileprivate func generateSpiralOfEnemy() {
    let enemyTextureAtlas1 = SKTextureAtlas(named: "Enemy_1")
    let enemyTextureAtlas2 = SKTextureAtlas(named: "Enemy_2")
    SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas1, enemyTextureAtlas2]) { [unowned self] in
      
      let randomNumber = Int(arc4random_uniform(2))
      let arrayOfAtlasses = [enemyTextureAtlas1, enemyTextureAtlas2]
      let textureAtlases = arrayOfAtlasses[randomNumber]
      
      let waitAction = SKAction.wait(forDuration: 1)
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
  
  fileprivate func spawnEnemies() {
    let waitAction = SKAction.wait(forDuration: 3.0)
    let genirateSpiralEnemy = SKAction.run { [unowned self] in
      self.generateSpiralOfEnemy()
    }
    let sequenceAction = SKAction.sequence([waitAction, genirateSpiralEnemy])
    let repeatAction = SKAction.repeatForever(sequenceAction)
    self.run(repeatAction)
  }
  
  override func didMove(to view: SKView) {
    
    configureStartScene()
    playerPlane.preloadTextureArrays()
    spawnIsland()
    spawnCloud()
    
    spawnPowerUp()
    
    spawnEnemies()
    
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
      if node.position.y < -100 {
        node.removeFromParent()
      }
    }
  }
  
}
