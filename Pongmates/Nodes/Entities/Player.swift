//
//  Player.swift
//  Pongmates
//
//  Created by Vladislav Kulikov on 15.05.2020.
//  Copyright © 2020 Vladislav Kulikov. All rights reserved.
//

import SpriteKit
import GameplayKit

class Player: GKEntity {
    
    // MARK: - Initializers
    
    init(size: CGSize, color: SKColor) {
        super.init()
        
        let node = NodeComponent()
        addComponent(node)
        
        let shape = ShapeComponent(rectOf: size, cornerRadius: 0, color: color)
        addComponent(shape)
        
        let physicsBody = PhysicsBodyComponent(physicsBody: SKPhysicsBody(rectangleOf: size), isDynamic: false, affectedByGravity: false, allowsRotation: false)
        addComponent(physicsBody)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func move(to position: CGFloat, withDuration time: TimeInterval) {
        if let node = component(ofType: NodeComponent.self)?.node {
            let moveTo = SKAction.moveTo(x: position, duration: time)
            
            node.run(moveTo)
        }
    }
    
    func rotate(byAngle angle: CGFloat, withDuration time: TimeInterval) {
        if let node = component(ofType: NodeComponent.self)?.node {
            let rotate = SKAction.rotate(byAngle: angle, duration: time)
            
            node.run(rotate)
        }
    }
    
}
