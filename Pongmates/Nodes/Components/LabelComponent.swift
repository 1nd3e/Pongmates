//
//  LabelComponent.swift
//  Pongmates
//
//  Created by Vladislav Kulikov on 15.05.2020.
//  Copyright © 2020 Vladislav Kulikov. All rights reserved.
//

import SpriteKit
import GameplayKit

class LabelComponent: GKComponent {
    
    // MARK: - Properties
    
    let node: SKLabelNode
    
    // MARK: - Initializers
    
    init(fontName: String, fontSize: CGFloat) {
        node = SKLabelNode()
        node.fontName = fontName
        node.fontSize = fontSize
        node.horizontalAlignmentMode = .center
        node.verticalAlignmentMode = .center
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func didAddToEntity() {
        if let node = entity?.component(ofType: NodeComponent.self)?.node {
            node.addChild(self.node)
        }
    }
    
}
