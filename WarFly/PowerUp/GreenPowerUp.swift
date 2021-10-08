
import SpriteKit

class GreenPowerUp: PowerUp {
  init() {
    let textureAtlas = SKTextureAtlas(named: "GreenPowerUp")
    super.init(textureAtlas: textureAtlas)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
