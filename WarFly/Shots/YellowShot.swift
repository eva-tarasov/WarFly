
import SpriteKit

class YellowShot: Shot {
  init() {
    let textureAtlas = SKTextureAtlas(named: "YellowAmmo")
    super.init(textureAtlas: textureAtlas)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
