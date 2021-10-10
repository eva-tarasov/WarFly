
import SpriteKit

class YellowShot: Shot {
  init() {
    let textureAtlas = Assets.shared.yellowAmmoAtlas
    super.init(textureAtlas: textureAtlas)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
