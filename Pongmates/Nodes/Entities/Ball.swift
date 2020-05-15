//
//  Ball.swift
//  Pongmates
//
//  Created by Vladislav Kulikov on 15.05.2020.
//  Copyright © 2020 Vladislav Kulikov. All rights reserved.
//

import SpriteKit
import GameplayKit

class Ball: GKEntity {
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        
        let node = NodeComponent()
        addComponent(node)
        
        let shape = ShapeComponent(rectOf: CGSize(width: 16, height: 16), cornerRadius: 8, color: SKColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00))
        addComponent(shape)
        
        let physicsBody = PhysicsBodyComponent(physicsBody: SKPhysicsBody(circleOfRadius: 8))
        addComponent(physicsBody)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func applyImpulse() {
        if let node = component(ofType: NodeComponent.self)?.node {
            let wait = SKAction.wait(forDuration: 0.5)
            let applyImpulse = SKAction.applyImpulse(CGVector(dx: 5, dy: 5), duration: 0.5)
            let sequence = SKAction.sequence([wait, applyImpulse])
            
            node.run(sequence)
        }
    }
    
}
