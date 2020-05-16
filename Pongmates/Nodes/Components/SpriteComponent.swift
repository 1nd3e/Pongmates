//
//  SpriteComponent.swift
//  Pongmates
//
//  Created by Vladislav Kulikov on 16.05.2020.
//  Copyright © 2020 Vladislav Kulikov. All rights reserved.
//

import SpriteKit
import GameplayKit

class SpriteComponent: GKComponent {
    
    // MARK: - Properties
    
    private let node: SKSpriteNode
    
    // MARK: - Initializers
    
    init(texture: SKTexture, size: CGSize) {
        node = SKSpriteNode(texture: texture, size: size)
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func didAddToEntity() {
        if let nodeComponent = entity?.component(ofType: NodeComponent.self) {
            node.entity = nodeComponent.entity
            nodeComponent.node = node
        }
    }
    
}
