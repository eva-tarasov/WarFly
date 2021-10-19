
import SpriteKit

class MenuScene: SKScene {
  
  override func didMove(to view: SKView) {
    Assets.shared.preloadAtlases()
    self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1)
    let texture = SKTexture(imageNamed: "play")
    let buttonPlay = SKSpriteNode(texture: texture)
    buttonPlay.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
    buttonPlay.name = "runButton"
    self.addChild(buttonPlay)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let location = touches.first?.location(in: self) else { return }
    // получаем нод под только что определенной точкой касания
    let node = self.atPoint(location)
    if node.name == "runButton" {
      let transition = SKTransition.crossFade(withDuration: 1.0)
      let gameScene = GameScene(size: self.size)
      gameScene.scaleMode = .aspectFill
      self.scene?.view?.presentScene(gameScene, transition: transition)
    }
  }
}
