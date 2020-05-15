//
//  Label.swift
//  Pongmates
//
//  Created by Vladislav Kulikov on 15.05.2020.
//  Copyright © 2020 Vladislav Kulikov. All rights reserved.
//

import SpriteKit
import GameplayKit

class Label: GKEntity {
    
    // MARK: - Initializers
    
    init(fontName: String, fontSize: CGFloat) {
        super.init()
        
        let node = NodeComponent()
        addComponent(node)
        
        let label = LabelComponent(fontName: fontName, fontSize: fontSize)
        addComponent(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func set(_ score: Int) {
        if let labelNode = component(ofType: LabelComponent.self)?.node {
            labelNode.text = String(score)
        }
    }
    
}
