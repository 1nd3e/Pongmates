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
    
    private var purchaseButton: Button!
    private var restoreButton: Button!
    
    private var playerA: Player!
    private var playerB: Player!
    private var ball: Ball!
    
    private var entities = Set<GKEntity>()
    
    private var adsDisabled: Bool {
        return Defaults.shared.adsDisabled
    }
    
}

// MARK: - Scene Events

extension StartScene {
    
    override func sceneDidLoad() {
        IAPService.shared.delegate = self
    }
    
    override func didMove(to view: SKView) {
        // Настраиваем параметры сцены игры
        setupPhysics()
        
        // Размещаем элементы интерфейса
        configurePlayButton()
        configurePurchaseButton()
        configureRestoreButton()
        
        // Размещаем дополнительные элементы окружения
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
                labelNode.text = NSLocalizedString("Let’s Play", comment: "Start a game")
                labelNode.fontColor = SKColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
            }
        }
        
        addEntity(button)
    }
    
    private func playButtonPressed() {
        if let scene = GKScene(fileNamed: "PickerAScene") {
            if let sceneNode = scene.rootNode as? PickerAScene {
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
        
        purchaseButton = Button(size: size, color: color)
        purchaseButton.name = "Remove Ads"
        
        if let node = purchaseButton.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.midY)
            node.zPosition = 1
        }
        
        if let labelNode = purchaseButton.component(ofType: LabelComponent.self)?.node {
            labelNode.text = NSLocalizedString("Remove Ads", comment: "Request a purchase")
            labelNode.fontColor = SKColor(red: 0.14, green: 0.04, blue: 0.27, alpha: 1.00)
            
            if adsDisabled {
                labelNode.alpha = 0.25
            }
        }
        
        addEntity(purchaseButton)
    }
    
    private func disablePurchaseButton() {
        let fadeAlpha = SKAction.fadeAlpha(to: 0.25, duration: 0.4)
        fadeAlpha.timingMode = .easeInEaseOut
        
        if let labelNode = purchaseButton.component(ofType: LabelComponent.self)?.node {
            labelNode.run(fadeAlpha)
        }
    }
    
    private func purchaseButtonPressed() {
        if adsDisabled == false {
            IAPService.shared.removeAds()
        }
    }
    
    private func configureRestoreButton() {
        let size = CGSize(width: 224, height: 48)
        let color = SKColor(red: 1.00, green: 0.76, blue: 0.03, alpha: 1.00)
        
        restoreButton = Button(size: size, color: color)
        restoreButton.name = "Restore Purchases"
        
        if let node = restoreButton.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.midY - 64)
            node.zPosition = 1
        }
        
        if let labelNode = restoreButton.component(ofType: LabelComponent.self)?.node {
            labelNode.text = NSLocalizedString("Restore Purchases", comment: "Request to restore purchases")
            labelNode.fontColor = SKColor(red: 0.14, green: 0.04, blue: 0.27, alpha: 1.00)
            
            if adsDisabled {
                labelNode.alpha = 0.25
            }
        }
        
        addEntity(restoreButton)
    }
    
    private func disableRestoreButton() {
        let fadeAlpha = SKAction.fadeAlpha(to: 0.25, duration: 0.4)
        fadeAlpha.timingMode = .easeInEaseOut
        
        if let labelNode = restoreButton.component(ofType: LabelComponent.self)?.node {
            labelNode.run(fadeAlpha)
        }
    }
    
    private func restoreButtonPressed() {
        if adsDisabled == false {
            IAPService.shared.restorePurchases()
        }
    }
    
}

// MARK: - Environment Entities

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

// MARK: - IAPServiceDelegate

extension StartScene: IAPServiceDelegate {
    
    func adsDidDisabled() {
        disablePurchaseButton()
        disableRestoreButton()
    }
    
}
