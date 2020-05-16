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
    
    var playerARacket: RacketType!
    var playerBRacket: RacketType!
    
    private var playerA: Player!
    private var playerB: Player!
    private var ball: Ball!
    
    private var entities = Set<GKEntity>()
    
}

// MARK: - Scene Events

extension EndScene {
    
    override func didMove(to view: SKView) {
        // Настраиваем параметры сцены игры
        setupPhysics()
        
        // Размещаем элементы интерфейса
        configureRestartButton()
        configureQuitButton()
        
        // Размещаем дополнительные элементы окружения
        configurePlayerA()
        configurePlayerB()
        configureBall()
        
        // Запускаем мяч
        ball.applyImpulse()
        
        // Пробуем отправить запрос оценки игры
        SKReview.shared.requestReviewIfAppropriate()
    }
    
}

// MARK: - Scene Configuration

extension EndScene {
    
    private func setupPhysics() {
        let physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody.friction = 0
        physicsBody.restitution = 1
        
        self.physicsBody = physicsBody
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
                labelNode.text = NSLocalizedString("Restart", comment: "Restart the current game")
                labelNode.fontColor = SKColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
            }
        }
        
        addEntity(button)
    }
    
    private func restartButtonPressed() {
        if let scene = GKScene(fileNamed: "GameScene") {
            if let sceneNode = scene.rootNode as? GameScene {
                sceneNode.size = self.size
                sceneNode.scaleMode = .aspectFill
                
                sceneNode.playerARacket = playerARacket
                sceneNode.playerBRacket = playerBRacket
                
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
                labelNode.text = NSLocalizedString("Quit", comment: "Quit to main menu")
                labelNode.fontColor = SKColor(red: 0.14, green: 0.04, blue: 0.27, alpha: 1.00)
            }
        }
        
        addEntity(button)
    }
    
    private func quitButtonPressed() {
        if let scene = GKScene(fileNamed: "StartScene") {
            if let sceneNode = scene.rootNode as? StartScene {
                sceneNode.size = self.size
                sceneNode.scaleMode = .aspectFill
                
                let sceneTransition = SKTransition.fade(with: SKColor(red: 0.14, green: 0.04, blue: 0.27, alpha: 1.00), duration: 0.5)
                sceneTransition.pausesOutgoingScene = false
                
                view?.presentScene(sceneNode, transition: sceneTransition)
            }
        }
    }
    
}

// MARK: - Environment Entities

extension EndScene {
    
    private func configurePlayerA() {
        var size = CGSize(width: 80, height: 16)
        var color = SKColor(red: 0.33, green: 0.09, blue: 0.32, alpha: 1.00)
        
        switch playerARacket {
        case .nimbler:
            size = CGSize(width: 80, height: 16)
            color = SKColor(red: 0.33, green: 0.09, blue: 0.32, alpha: 1.00)
        case .keeper:
            size = CGSize(width: 160, height: 16)
            color = SKColor(red: 0.22, green: 0.10, blue: 0.45, alpha: 1.00)
        case .winger:
            size = CGSize(width: 120, height: 16)
            color = SKColor(red: 0.50, green: 0.38, blue: 0.01, alpha: 1.00)
        default:
            break
        }
        
        playerA = Player(size: size, color: color)
        
        if let node = playerA.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.minY + 104)
            node.zPosition = 0
        }
        
        addEntity(playerA)
    }
    
    private func configurePlayerB() {
        var size = CGSize(width: 80, height: 16)
        var color = SKColor(red: 0.22, green: 0.10, blue: 0.45, alpha: 1.00)
        
        switch playerBRacket {
        case .nimbler:
            size = CGSize(width: 80, height: 16)
            color = SKColor(red: 0.33, green: 0.09, blue: 0.32, alpha: 1.00)
        case .keeper:
            size = CGSize(width: 160, height: 16)
            color = SKColor(red: 0.22, green: 0.10, blue: 0.45, alpha: 1.00)
        case .winger:
            size = CGSize(width: 120, height: 16)
            color = SKColor(red: 0.50, green: 0.38, blue: 0.01, alpha: 1.00)
        default:
            break
        }
        
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
