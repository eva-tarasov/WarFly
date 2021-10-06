//
//  Protocols.swift
//  WarFly
//
//  Created by Evgeny Tarasov on 06.10.2021.
//

import SpriteKit

protocol GameBackgroundSpriteable {
    static func createElement(at point: CGPoint) -> Self
}
