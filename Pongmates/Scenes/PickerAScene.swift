//
//  PickerAScene.swift
//  Pongmates
//
//  Created by Vladislav Kulikov on 16.05.2020.
//  Copyright © 2020 Vladislav Kulikov. All rights reserved.
//

import SpriteKit
import GameplayKit

class PickerAScene: SKScene {
    
    private var racketA: Player!
    private var racketB: Player!
    private var racketC: Player!
    
    private var entities = Set<GKEntity>()
    
}

// MARK: - Scene Events

extension PickerAScene {
    
    override func didMove(to view: SKView) {
        // Размещаем элементы интерфейса
        configureTitleLabel()
        configureSubtitleLabel()
        configureRevertButton()
        
        // Размещаем ракетки
        configureRacketA()
        configureRacketAButton()
        configureRacketB()
        configureRacketBButton()
        configureRacketC()
        configureRacketCButton()
        
        // Запускаем анимации ракеток
        animateRacketA()
        animateRacketB()
        animateRacketC()
    }
    
}

// MARK: - UI Entities

extension PickerAScene {
    
    private func configureTitleLabel() {
        let label = Label(fontName: "SFProText-Medium", fontSize: 17)
        
        if let node = label.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.maxY - 72)
            
            if let labelNode = label.component(ofType: LabelComponent.self)?.node {
                labelNode.text = "Player 1"
                labelNode.fontColor = SKColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
            }
        }
        
        addEntity(label)
    }
    
    private func configureSubtitleLabel() {
        let label = Label(fontName: "SFProText-Medium", fontSize: 17)
        
        if let node = label.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.maxY - 96)
            
            if let labelNode = label.component(ofType: LabelComponent.self)?.node {
                labelNode.text = "Pick your Racket"
                labelNode.fontColor = SKColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
            }
        }
        
        addEntity(label)
    }
    
    private func configureRevertButton() {
        let texture = SKTexture(imageNamed: "ic-arrow-back")
        let size = CGSize(width: 48, height: 48)
        
        let button = Button(texture: texture, size: size)
        button.name = "Revert"
        
        if let node = button.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.minY + 72)
        }
        
        addEntity(button)
    }
    
    private func revertButtonPressed() {
        if let scene = GKScene(fileNamed: "StartScene") {
            if let sceneNode = scene.rootNode as? StartScene {
                sceneNode.size = self.size
                
                let sceneTransition = SKTransition.fade(with: SKColor(red: 0.29, green: 0.08, blue: 0.55, alpha: 1.00), duration: 0.5)
                sceneTransition.pausesOutgoingScene = false
                
                view?.presentScene(sceneNode, transition: sceneTransition)
            }
        }
    }
    
}

// MARK: - Racket Entities

extension PickerAScene {
    
    private func configureRacketA() {
        let size = CGSize(width: 80, height: 16)
        let color = SKColor(red: 0.91, green: 0.12, blue: 0.39, alpha: 1.00)
        
        racketA = Player(size: size, color: color)
        
        if let node = racketA.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX - 112, y: frame.midY + 168)
            node.zPosition = 0
        }
        
        addEntity(racketA)
    }
    
    private func animateRacketA() {
        let moveToMaxX = SKAction.moveTo(x: frame.midX + 112, duration: 0.25)
        moveToMaxX.timingMode = .easeInEaseOut
        let moveToMinX = SKAction.moveTo(x: frame.midX - 112, duration: 0.25)
        moveToMinX.timingMode = .easeInEaseOut
        
        let sequence = SKAction.sequence([moveToMaxX, moveToMinX])
        
        if let node = racketA.component(ofType: NodeComponent.self)?.node {
            node.run(.repeatForever(sequence))
        }
    }
    
    private func configureRacketAButton() {
        let size = CGSize(width: 224, height: 48)
        let color = SKColor(red: 0.91, green: 0.12, blue: 0.39, alpha: 1.00)
        
        let button = Button(size: size, color: color)
        button.name = "Racket A"
        
        if let node = button.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.midY + 104)
            node.zPosition = 1
            
            if let labelNode = button.component(ofType: LabelComponent.self)?.node {
                labelNode.text = "Pick"
                labelNode.fontColor = SKColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
            }
        }
        
        addEntity(button)
    }
    
    private func racketAButtonPressed() {
        if let scene = GKScene(fileNamed: "PickerBScene") {
            if let sceneNode = scene.rootNode as? PickerBScene {
                sceneNode.size = self.size
                sceneNode.selectedRacketA = .nimbler
                
                let sceneTransition = SKTransition.fade(with: SKColor(red: 0.29, green: 0.08, blue: 0.55, alpha: 1.00), duration: 0.5)
                sceneTransition.pausesOutgoingScene = false
                
                view?.presentScene(sceneNode, transition: sceneTransition)
            }
        }
    }
    
    private func configureRacketB() {
        let size = CGSize(width: 160, height: 16)
        let color = SKColor(red: 0.49, green: 0.30, blue: 1.00, alpha: 1.00)
        
        racketB = Player(size: size, color: color)
        
        if let node = racketB.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX + 112, y: frame.midY + 40)
            node.zPosition = 0
        }
        
        addEntity(racketB)
    }
    
    private func animateRacketB() {
        let moveToMinX = SKAction.moveTo(x: frame.midX - 112, duration: 0.65)
        moveToMinX.timingMode = .easeInEaseOut
        let moveToMaxX = SKAction.moveTo(x: frame.midX + 112, duration: 0.65)
        moveToMaxX.timingMode = .easeInEaseOut
        
        let sequence = SKAction.sequence([moveToMinX, moveToMaxX])
        
        if let node = racketB.component(ofType: NodeComponent.self)?.node {
            node.run(.repeatForever(sequence))
        }
    }
    
    private func configureRacketBButton() {
        let size = CGSize(width: 224, height: 48)
        let color = SKColor(red: 0.49, green: 0.30, blue: 1.00, alpha: 1.00)
        
        let button = Button(size: size, color: color)
        button.name = "Racket B"
        
        if let node = button.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.midY - 24)
            node.zPosition = 1
            
            if let labelNode = button.component(ofType: LabelComponent.self)?.node {
                labelNode.text = "Watch Ads"
                labelNode.fontColor = SKColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
            }
        }
        
        addEntity(button)
    }
    
    private func racketBButtonPressed() {
        if let scene = GKScene(fileNamed: "PickerBScene") {
            if let sceneNode = scene.rootNode as? PickerBScene {
                sceneNode.size = self.size
                sceneNode.selectedRacketA = .keeper
                
                let sceneTransition = SKTransition.fade(with: SKColor(red: 0.29, green: 0.08, blue: 0.55, alpha: 1.00), duration: 0.5)
                sceneTransition.pausesOutgoingScene = false
                
                view?.presentScene(sceneNode, transition: sceneTransition)
            }
        }
    }
    
    private func configureRacketC() {
        let size = CGSize(width: 120, height: 16)
        let color = SKColor(red: 1.00, green: 0.76, blue: 0.03, alpha: 1.00)
        
        racketC = Player(size: size, color: color)
        
        if let node = racketC.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX - 112, y: frame.midY - 88)
            node.zPosition = 0
        }
        
        addEntity(racketC)
    }
    
    private func animateRacketC() {
        let moveToMaxX = SKAction.moveTo(x: frame.midX + 112, duration: 0.35)
        moveToMaxX.timingMode = .easeInEaseOut
        let moveToMinX = SKAction.moveTo(x: frame.midX - 112, duration: 0.35)
        moveToMinX.timingMode = .easeInEaseOut
        
        let wait = SKAction.wait(forDuration: 0.125)
        
        let rotateToLT = SKAction.rotate(byAngle: CGFloat.pi, duration: 0.125)
        rotateToLT.timingMode = .easeInEaseOut
        let rotateToRT = SKAction.rotate(byAngle: -CGFloat.pi, duration: 0.125)
        rotateToRT.timingMode = .easeInEaseOut
        
        let sequence = SKAction.sequence([moveToMaxX, wait, rotateToLT, wait, moveToMinX, wait, rotateToRT, wait])
        
        if let node = racketC.component(ofType: NodeComponent.self)?.node {
            node.run(.repeatForever(sequence))
        }
    }
    
    private func configureRacketCButton() {
        let size = CGSize(width: 224, height: 48)
        let color = SKColor(red: 1.00, green: 0.76, blue: 0.03, alpha: 1.00)
        
        let button = Button(size: size, color: color)
        button.name = "Racket C"
        
        if let node = button.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.midY - 152)
            node.zPosition = 1
            
            if let labelNode = button.component(ofType: LabelComponent.self)?.node {
                labelNode.text = "Watch Ads"
                labelNode.fontColor = SKColor(red: 0.14, green: 0.04, blue: 0.27, alpha: 1.00)
            }
        }
        
        addEntity(button)
    }
    
    private func racketCButtonPressed() {
        if let scene = GKScene(fileNamed: "PickerBScene") {
            if let sceneNode = scene.rootNode as? PickerBScene {
                sceneNode.size = self.size
                sceneNode.selectedRacketA = .winger
                
                let sceneTransition = SKTransition.fade(with: SKColor(red: 0.29, green: 0.08, blue: 0.55, alpha: 1.00), duration: 0.5)
                sceneTransition.pausesOutgoingScene = false
                
                view?.presentScene(sceneNode, transition: sceneTransition)
            }
        }
    }
    
}

// MARK: - Entity Methods

extension PickerAScene {
    
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

extension PickerAScene {
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            
            if let button = node.entity as? Button {
                if button.name == "Racket A" {
                    racketAButtonPressed()
                } else if button.name == "Racket B" {
                    racketBButtonPressed()
                } else if button.name == "Racket C" {
                    racketCButtonPressed()
                } else if button.name == "Revert" {
                    revertButtonPressed()
                }
            }
        }
    }
    
}
