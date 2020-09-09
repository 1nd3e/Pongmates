//
//  PhysicsBodyComponent.swift
//  Pongmates
//
//  Created by Vladislav Kulikov on 15.05.2020.
//  Copyright © 2020 Vladislav Kulikov. All rights reserved.
//

import SpriteKit
import GameplayKit

class PhysicsBodyComponent: GKComponent {
    
    // MARK: - Public Properties
    
    let physicsBody: SKPhysicsBody
    
    // MARK: - Private Properties
    
    private var isDynamic = true
    private var affectedByGravity = false
    private var allowsRotation = false
    
    // MARK: - Initializers
    
    init(physicsBody: SKPhysicsBody) {
        self.physicsBody = physicsBody
        
        super.init()
    }
    
    init(physicsBody: SKPhysicsBody, isDynamic: Bool, affectedByGravity: Bool, allowsRotation: Bool) {
        self.physicsBody = physicsBody
        self.isDynamic = isDynamic
        self.affectedByGravity = affectedByGravity
        self.allowsRotation = allowsRotation
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func didAddToEntity() {
        physicsBody.isDynamic = isDynamic
        physicsBody.affectedByGravity = affectedByGravity
        physicsBody.allowsRotation = allowsRotation
        physicsBody.friction = 0
        physicsBody.restitution = 1
        physicsBody.linearDamping = 0
        physicsBody.angularDamping = 0
        physicsBody.usesPreciseCollisionDetection = true
        
        if let node = entity?.component(ofType: NodeComponent.self)?.node {
            node.physicsBody = physicsBody
        }
    }
    
}
