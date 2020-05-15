//
//  EndScene.swift
//  Pongmates
//
//  Created by Vladislav Kulikov on 15.05.2020.
//  Copyright © 2020 Vladislav Kulikov. All rights reserved.
//

import SpriteKit
import GameplayKit

class EndScene: SKScene {
    
    private var entities = Set<GKEntity>()
    
}

// MARK: - Scene Events

extension EndScene {
    
    override func didMove(to view: SKView) {
        configureRestartButton()
        configureQuitButton()
    }
    
}

// MARK: - UI Entities

extension EndScene {
    
    private func configureRestartButton() {
        let size = CGSize(width: 224, height: 48)
        let color = SKColor(red: 0.91, green: 0.12, blue: 0.39, alpha: 1.00)
        
        let button = Button(size: size, color: color)
        button.name = "Restart"
        
        if let node = button.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.midY + 32)
            node.zPosition = 1
            
            if let labelNode = button.component(ofType: LabelComponent.self)?.node {
                labelNode.text = "Restart"
                labelNode.fontColor = SKColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
            }
        }
        
        self.addEntity(button)
    }
    
    private func restartButtonPressed() {
        if let scene = GKScene(fileNamed: "MultiplayerScene") {
            if let sceneNode = scene.rootNode as? MultiplayerScene {
                sceneNode.size = self.size
                
                let sceneTransition = SKTransition.fade(with: SKColor(red: 0.29, green: 0.08, blue: 0.55, alpha: 1.00), duration: 0.5)
                sceneTransition.pausesOutgoingScene = false
                
                view?.presentScene(sceneNode, transition: sceneTransition)
            }
        }
    }
    
    private func configureQuitButton() {
        let size = CGSize(width: 224, height: 48)
        let color = SKColor(red: 1.00, green: 0.76, blue: 0.03, alpha: 1.00)
        
        let button = Button(size: size, color: color)
        button.name = "Quit"
        
        if let node = button.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.midY - 32)
            node.zPosition = 1
            
            if let labelNode = button.component(ofType: LabelComponent.self)?.node {
                labelNode.text = "Quit"
                labelNode.fontColor = SKColor(red: 0.14, green: 0.04, blue: 0.27, alpha: 1.00)
            }
        }
        
        self.addEntity(button)
    }
    
    private func quitButtonPressed() {
        if let scene = GKScene(fileNamed: "StartScene") {
            if let sceneNode = scene.rootNode as? StartScene {
                sceneNode.size = self.size
                
                let sceneTransition = SKTransition.fade(with: SKColor(red: 0.14, green: 0.04, blue: 0.27, alpha: 1.00), duration: 0.5)
                sceneTransition.pausesOutgoingScene = false
                
                view?.presentScene(sceneNode, transition: sceneTransition)
            }
        }
    }
    
}

// MARK: - Entity Methods

extension EndScene {
    
    private func addEntity(_ entity: GKEntity) {
        entities.insert(entity)
        
        if let node = entity.component(ofType: NodeComponent.self)?.node {
            addChild(node)
        }
    }
    
    private func removeEntity(_ entity: GKEntity) {
        if let node = entity.component(ofType: NodeComponent.self)?.node {
            node.removeFromParent()
        }
        
        entities.remove(entity)
    }
    
}

// MARK: - Touch Events

extension EndScene {
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            
            if let button = node.entity as? Button {
                if button.name == "Restart" {
                    restartButtonPressed()
                } else if button.name == "Quit" {
                    quitButtonPressed()
                }
            }
        }
    }
    
}
