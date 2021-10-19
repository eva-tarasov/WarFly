//
//  HUD.swift
//  WarFly
//
//  Created by Евгений Тарасов on 19.10.2021.
//

import SpriteKit

class HUD: SKScene {
  
  private let scoreBackground = SKSpriteNode(imageNamed: "scores")
  private let scoreLabel = SKLabelNode(text: "1000")
  private let menuButton = SKSpriteNode(imageNamed: "menu")
  private let life1 = SKSpriteNode(imageNamed: "life")
  private let life2 = SKSpriteNode(imageNamed: "life")
  private let life3 = SKSpriteNode(imageNamed: "life")
  
  func configureUI(screenSize: CGSize) {
    scoreBackground.position = CGPoint(x: 16, y: screenSize.height - 36)
    scoreBackground.anchorPoint = CGPoint(x: 0, y: 1)
    scoreBackground.zPosition = 99
    scoreBackground.setScale(0.8)
    addChild(scoreBackground)
    
    scoreLabel.horizontalAlignmentMode = .right
    scoreLabel.verticalAlignmentMode = .center
    scoreLabel.position = CGPoint(x: scoreBackground.size.width + 10, y: -scoreBackground.size.height * 0.5 - 3)
    scoreLabel.zPosition = 100
    scoreLabel.fontName = "AmericanTypewriter-Bold"
    scoreLabel.fontSize = 30
    scoreBackground.addChild(scoreLabel)
    
    menuButton.anchorPoint = CGPoint(x: 0, y: 0)
    menuButton.position = CGPoint(x: 18, y: 18)
    menuButton.zPosition = 100
    addChild(menuButton)
    
    let lifes = [life1, life2, life3]
    
    for (index, life) in lifes.enumerated() {
      life.position = CGPoint(x: screenSize.width - CGFloat(index + 1) * (life.size.width + 5), y: screenSize.height - life.size.height - 50)
      life.zPosition = 100
      life.anchorPoint = CGPoint(x: 0, y: 0)
      
      addChild(life)
    }
    
  }
}
