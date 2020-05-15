//
//  StartScene.swift
//  Pongmates
//
//  Created by Vladislav Kulikov on 13.05.2020.
//  Copyright © 2020 Vladislav Kulikov. All rights reserved.
//

import SpriteKit
import GameplayKit

class StartScene: SKScene {
    
    private var playerA: Player!
    private var playerB: Player!
    private var ball: Ball!
    
    private var entities = Set<GKEntity>()
    
}

// MARK: - Scene Events

extension StartScene {
    
    override func didMove(to view: SKView) {
        // Настраиваем параметры сцены игры
        setupPhysics()
        
        // Размещаем элементы интерфейса
        configurePlayButton()
        configurePurchaseButton()
        configureRestoreButton()
        configurePlayerA()
        configurePlayerB()
        configureBall()
        
        // Запускаем мяч
        ball.applyImpulse()
    }
    
}

// MARK: - Scene Configuration

extension StartScene {
    
    private func setupPhysics() {
        let physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody.friction = 0
        physicsBody.restitution = 1
        
        self.physicsBody = physicsBody
    }
    
}

// MARK: - UI Entities

extension StartScene {
    
    private func configurePlayButton() {
        let size = CGSize(width: 224, height: 48)
        let color = SKColor(red: 0.91, green: 0.12, blue: 0.39, alpha: 1.00)
        
        let button = Button(size: size, color: color)
        button.name = "Play"
        
        if let node = button.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.midY + 64)
            node.zPosition = 1
            
            if let labelNode = button.component(ofType: LabelComponent.self)?.node {
                labelNode.text = "Let's Play"
                labelNode.fontColor = SKColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
            }
        }
        
        self.addEntity(button)
    }
    
    private func playButtonPressed() {
        if let scene = GKScene(fileNamed: "MultiplayerScene") {
            if let sceneNode = scene.rootNode as? MultiplayerScene {
                sceneNode.size = self.size
                
                let sceneTransition = SKTransition.fade(with: SKColor(red: 0.29, green: 0.08, blue: 0.55, alpha: 1.00), duration: 0.5)
                sceneTransition.pausesOutgoingScene = false
                
                view?.presentScene(sceneNode, transition: sceneTransition)
            }
        }
    }
    
    private func configurePurchaseButton() {
        let size = CGSize(width: 224, height: 48)
        let color = SKColor(red: 1.00, green: 0.76, blue: 0.03, alpha: 1.00)
        
        let button = Button(size: size, color: color)
        button.name = "Remove Ads"
        
        if let node = button.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.midY)
            node.zPosition = 1
            
            if let labelNode = button.component(ofType: LabelComponent.self)?.node {
                labelNode.text = "Remove Ads"
                labelNode.fontColor = SKColor(red: 0.14, green: 0.04, blue: 0.27, alpha: 1.00)
            }
        }
        
        self.addEntity(button)
    }
    
    private func purchaseButtonPressed() {}
    
    private func configureRestoreButton() {
        let size = CGSize(width: 224, height: 48)
        let color = SKColor(red: 1.00, green: 0.76, blue: 0.03, alpha: 1.00)
        
        let button = Button(size: size, color: color)
        button.name = "Restore Purchases"
        
        if let node = button.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.midY - 64)
            node.zPosition = 1
            
            if let labelNode = button.component(ofType: LabelComponent.self)?.node {
                labelNode.text = "Restore Purchases"
                labelNode.fontColor = SKColor(red: 0.14, green: 0.04, blue: 0.27, alpha: 1.00)
            }
        }
        
        self.addEntity(button)
    }
    
    private func restoreButtonPressed() {}
    
}

// MARK: - Node Methods

extension StartScene {
    
    private func configurePlayerA() {
        let size = CGSize(width: 80, height: 16)
        let color = SKColor(red: 0.33, green: 0.09, blue: 0.32, alpha: 1.00)
        
        playerA = Player(size: size, color: color)
        
        if let node = playerA.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.minY + 104)
            node.zPosition = 0
        }
        
        addEntity(playerA)
    }
    
    private func configurePlayerB() {
        let size = CGSize(width: 160, height: 16)
        let color = SKColor(red: 0.22, green: 0.10, blue: 0.45, alpha: 1.00)
        
        playerB = Player(size: size, color: color)
        
        if let node = playerB.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.maxY - 104)
            node.zPosition = 0
        }
        
        addEntity(playerB)
    }
    
    private func configureBall() {
        ball = Ball(color: SKColor(red: 0.35, green: 0.28, blue: 0.45, alpha: 1.00))
        
        if let node = ball.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.midY)
            node.zPosition = 0
        }
        
        addEntity(ball)
    }
    
}

// MARK: - Entity Methods

extension StartScene {
    
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

extension StartScene {
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            
            if let button = node.entity as? Button {
                if button.name == "Play" {
                    playButtonPressed()
                } else if button.name == "Remove Ads" {
                    purchaseButtonPressed()
                } else if button.name == "Restore Purchases" {
                    restoreButtonPressed()
                }
            }
        }
    }
    
}
