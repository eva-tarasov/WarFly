
import SpriteKit

class Assets {
  static let shared = Assets()
  
  let yellowAmmoAtlas = SKTextureAtlas(named: "YellowAmmo")
  let bluePowerUpAtlas = SKTextureAtlas(named: "BluePowerUp")
  let greenPowerUpAtlas = SKTextureAtlas(named: "GreenPowerUp")
  let enemy_2Atlas = SKTextureAtlas(named: "Enemy_2")
  let enemy_1Atlas = SKTextureAtlas(named: "Enemy_1")
  let playerPlaneAtlas = SKTextureAtlas(named: "PlayerPlane")
  
  func preloadAtlases() {
    yellowAmmoAtlas.preload { print("yellowAmmoAtlas preload") }
    bluePowerUpAtlas.preload { print("bluePowerUpAtlas preload") }
    greenPowerUpAtlas.preload { print("greenPowerUpAtlas preload") }
    enemy_2Atlas.preload { print("enemy_2Atlas preload") }
    enemy_1Atlas.preload { print("enemy_1Atlas preload") }
    playerPlaneAtlas.preload { print("playerPlaneAtlas preload") }
  }
}
