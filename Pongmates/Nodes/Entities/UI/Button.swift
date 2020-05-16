//
//  Button.swift
//  Pongmates
//
//  Created by Vladislav Kulikov on 15.05.2020.
//  Copyright © 2020 Vladislav Kulikov. All rights reserved.
//

import SpriteKit
import GameplayKit

class Button: GKEntity {
    
    // MARK: - Properties
    
    var name = String()
    
    // MARK: - Initializers
    
    init(size: CGSize, color: SKColor) {
        super.init()
        
        let node = NodeComponent()
        addComponent(node)
        
        let shape = ShapeComponent(rectOf: size, cornerRadius: 8, color: color)
        addComponent(shape)
        
        let label = LabelComponent(fontName: "SFProText-Medium", fontSize: 17)
        addComponent(label)
    }
    
    init(texture: SKTexture, size: CGSize) {
        super.init()
        
        let node = NodeComponent()
        addComponent(node)
        
        let sprite = SpriteComponent(texture: texture, size: size)
        addComponent(sprite)
        
        let label = LabelComponent(fontName: "SFProText-Medium", fontSize: 17)
        addComponent(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
