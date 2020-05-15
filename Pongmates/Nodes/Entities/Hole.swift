//
//  Hole.swift
//  Pongmates
//
//  Created by Vladislav Kulikov on 15.05.2020.
//  Copyright © 2020 Vladislav Kulikov. All rights reserved.
//

import SpriteKit
import GameplayKit

class Hole: GKEntity {
    
    init(size: CGSize) {
        super.init()
        
        let node = NodeComponent()
        addComponent(node)
        
        let physicsBody = PhysicsBodyComponent(physicsBody: SKPhysicsBody(rectangleOf: size), isDynamic: false, affectedByGravity: false, allowsRotation: false)
        addComponent(physicsBody)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
