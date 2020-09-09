//
//  GameScene.swift
//  Pongmates
//
//  Created by Vladislav Kulikov on 15.05.2020.
//  Copyright © 2020 Vladislav Kulikov. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // MARK: - Public Properties
    
    var playerARacket: RacketType!
    var playerBRacket: RacketType!
    
    // MARK: - Private Properties
    
    private var playerA: Player!
    private var playerAScoreLabel: Label!
    private var playerB: Player!
    private var playerBScoreLabel: Label!
    private var ball: Ball!
    
    private var playerAScore = 0
    private var playerBScore = 0
    
    private var entities = Set<GKEntity>()
    
    // MARK: - Scene Events
    
    override func didMove(to view: SKView) {
        // Scene configuration.
        setupPhysics()
        
        // Preparing audio.
        prepareAudioPlayer()
        
        // Nodes configuration.
        configurePlayerA()
        configurePlayerAScoreLabel()
        configurePlayerAHole()
        configurePlayerB()
        configurePlayerBScoreLabel()
        configurePlayerBHole()
        configureBall()
        
        // Start the game.
        ball.applyImpulse()
    }
    
}

// MARK: - Scene Configuration

extension GameScene {
    
    private func setupPhysics() {
        let physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody.friction = 0
        physicsBody.restitution = 1
        
        self.physicsBody = physicsBody
        self.physicsWorld.contactDelegate = self
    }
    
}

// MARK: - Gameplay Entities

extension GameScene {
    
    private func configurePlayerA() {
        var size = CGSize(width: 80, height: 16)
        var color = SKColor(red: 0.91, green: 0.12, blue: 0.39, alpha: 1.00)
        
        switch playerARacket {
        case .nimbler:
            size = CGSize(width: 80, height: 16)
            color = SKColor(red: 0.91, green: 0.12, blue: 0.39, alpha: 1.00)
        case .keeper:
            size = CGSize(width: 160, height: 16)
            color = SKColor(red: 0.49, green: 0.30, blue: 1.00, alpha: 1.00)
        case .winger:
            size = CGSize(width: 120, height: 16)
            color = SKColor(red: 1.00, green: 0.76, blue: 0.03, alpha: 1.00)
        default:
            break
        }
        
        playerA = Player(size: size, color: color)
        
        if let node = playerA.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.minY + 104)
            node.zPosition = 1
            
            if let physicsBody = playerA.component(ofType: PhysicsBodyComponent.self)?.physicsBody {
                physicsBody.categoryBitMask = BitMaskCategory.playerA
                physicsBody.collisionBitMask = BitMaskCategory.ball
            }
        }
        
        addEntity(playerA)
    }
    
    private func configurePlayerAScoreLabel() {
        playerAScoreLabel = Label(fontName: "SFProDisplay-Ultralight", fontSize: 80)
        
        if let node = playerAScoreLabel.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.midY - 48)
            node.zPosition = 0
            
            if let labelNode = playerAScoreLabel.component(ofType: LabelComponent.self)?.node {
                labelNode.text = String(playerAScore)
                labelNode.fontColor = SKColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.25)
            }
        }
        
        addEntity(playerAScoreLabel)
    }
    
    private func configurePlayerAHole() {
        let hole = Hole(size: CGSize(width: frame.width, height: 96))
        
        if let node = hole.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.minY + 48)
            
            if let physicsBody = hole.component(ofType: PhysicsBodyComponent.self)?.physicsBody {
                physicsBody.categoryBitMask = BitMaskCategory.playerAHole
                physicsBody.contactTestBitMask = BitMaskCategory.ball
            }
        }
        
        addEntity(hole)
    }
    
    private func configurePlayerB() {
        var size = CGSize(width: 80, height: 16)
        var color = SKColor(red: 0.91, green: 0.12, blue: 0.39, alpha: 1.00)
        
        switch playerBRacket {
        case .nimbler:
            size = CGSize(width: 80, height: 16)
            color = SKColor(red: 0.91, green: 0.12, blue: 0.39, alpha: 1.00)
        case .keeper:
            size = CGSize(width: 160, height: 16)
            color = SKColor(red: 0.49, green: 0.30, blue: 1.00, alpha: 1.00)
        case .winger:
            size = CGSize(width: 120, height: 16)
            color = SKColor(red: 1.00, green: 0.76, blue: 0.03, alpha: 1.00)
        default:
            break
        }
        
        playerB = Player(size: size, color: color)
        
        if let node = playerB.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.maxY - 104)
            node.zPosition = 1
            
            if let physicsBody = playerB.component(ofType: PhysicsBodyComponent.self)?.physicsBody {
                physicsBody.categoryBitMask = BitMaskCategory.playerB
                physicsBody.collisionBitMask = BitMaskCategory.ball
            }
        }
        
        addEntity(playerB)
    }
    
    private func configurePlayerBScoreLabel() {
        playerBScoreLabel = Label(fontName: "SFProDisplay-Ultralight", fontSize: 80)
        
        if let node = playerBScoreLabel.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.midY + 48)
            node.zRotation = .pi
            node.zPosition = 0
            
            if let labelNode = playerBScoreLabel.component(ofType: LabelComponent.self)?.node {
                labelNode.text = String(playerBScore)
                labelNode.fontColor = SKColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.25)
            }
        }
        
        addEntity(playerBScoreLabel)
    }
    
    private func configurePlayerBHole() {
        let hole = Hole(size: CGSize(width: frame.width, height: 96))
        
        if let node = hole.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.maxY - 48)
            
            if let physicsBody = hole.component(ofType: PhysicsBodyComponent.self)?.physicsBody {
                physicsBody.categoryBitMask = BitMaskCategory.playerBHole
                physicsBody.contactTestBitMask = BitMaskCategory.ball
            }
        }
        
        addEntity(hole)
    }
    
    private func configureBall() {
        ball = Ball(color: SKColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00))
        
        if let node = ball.component(ofType: NodeComponent.self)?.node {
            node.position = CGPoint(x: frame.midX, y: frame.midY)
            node.zPosition = 1
            
            if let physicsBody = ball.component(ofType: PhysicsBodyComponent.self)?.physicsBody {
                physicsBody.categoryBitMask = BitMaskCategory.ball
                physicsBody.collisionBitMask = BitMaskCategory.playerA | BitMaskCategory.playerB
                physicsBody.contactTestBitMask = BitMaskCategory.playerAHole | BitMaskCategory.playerBHole
            }
        }
        
        addEntity(ball)
    }
    
}

// MARK: - SFX Methods

extension GameScene {
    
    private func play(soundFileNamed soundFile: String) {
        let playSoundFileNamed = SKAction.playSoundFileNamed(soundFile, waitForCompletion: false)
        run(playSoundFileNamed)
    }
    
    private func prepareAudioPlayer() {
        play(soundFileNamed: "audio-silence.wav")
    }
    
}

// MARK: - Gameplay Methods

extension GameScene {
    
    private func replayMatch(winner: PlayerType) {
        switch winner {
        case .playerA:
            if let node = playerA.component(ofType: NodeComponent.self)?.node {
                ball.resetPosition(to: CGPoint(x: node.position.x, y: node.position.y + 40))
                
                switch node.position.x {
                case frame.minX...0:
                    ball.applyImpulse(CGVector(dx: 5, dy: 5))
                case 0...frame.maxX:
                    ball.applyImpulse(CGVector(dx: -5, dy: 5))
                default:
                    break
                }
            }
        case .playerB:
            if let node = playerB.component(ofType: NodeComponent.self)?.node {
                ball.resetPosition(to: CGPoint(x: node.position.x, y: node.position.y - 40))
                
                switch node.position.x {
                case 0...frame.maxX:
                    ball.applyImpulse(CGVector(dx: -5, dy: -5))
                case frame.minX...0:
                    ball.applyImpulse(CGVector(dx: 5, dy: -5))
                default:
                    break
                }
            }
        }
    }
    
    private func finishMatch() {
        if let scene = GKScene(fileNamed: "EndScene") {
            if let sceneNode = scene.rootNode as? EndScene {
                sceneNode.size = self.size
                sceneNode.scaleMode = .aspectFill
                
                sceneNode.playerARacket = playerARacket
                sceneNode.playerBRacket = playerBRacket
                
                let sceneTransition = SKTransition.fade(with: SKColor(red: 0.14, green: 0.04, blue: 0.27, alpha: 1.00), duration: 0.5)
                sceneTransition.pausesOutgoingScene = false
                
                view?.presentScene(sceneNode, transition: sceneTransition)
            }
        }
    }
    
}

// MARK: - Entity Methods

extension GameScene {
    
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

extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        for touch in touches {
            let location = touch.location(in: self)
            let tapCount = touch.tapCount
            
            if tapCount == 2 {
                if location.y < 0 {
                    switch playerARacket {
                    case .winger:
                        if location.x < 0 {
                            playerA.rotate(byAngle: -CGFloat.pi, withDuration: 0.125)
                        } else {
                            playerA.rotate(byAngle: CGFloat.pi, withDuration: 0.125)
                        }
                    default:
                        break
                    }
                } else {
                    switch playerBRacket {
                    case .winger:
                        if location.x > 0 {
                            playerB.rotate(byAngle: -CGFloat.pi, withDuration: 0.125)
                        } else {
                            playerB.rotate(byAngle: CGFloat.pi, withDuration: 0.125)
                        }
                    default:
                        break
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if location.y < 0 {
                switch playerARacket {
                case .nimbler:
                    playerA.move(to: location.x, withDuration: 0.05)
                case .keeper:
                    playerA.move(to: location.x, withDuration: 0.30)
                case .winger:
                    playerA.move(to: location.x, withDuration: 0.15)
                default:
                    break
                }
            } else {
                switch playerBRacket {
                case .nimbler:
                    playerB.move(to: location.x, withDuration: 0.05)
                case .keeper:
                    playerB.move(to: location.x, withDuration: 0.30)
                case .winger:
                    playerB.move(to: location.x, withDuration: 0.15)
                default:
                    break
                }
            }
        }
    }
    
}

// MARK: - SKPhysicsContactDelegate

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA.categoryBitMask
        let bodyB = contact.bodyB.categoryBitMask
        
        let playerAHoleBody = BitMaskCategory.playerAHole
        let playerBHoleBody = BitMaskCategory.playerBHole
        let ballBody = BitMaskCategory.ball
        
        if bodyA == playerAHoleBody && bodyB == ballBody || bodyA == ballBody && bodyB == playerAHoleBody {
            playerBScore += 1
            playerBScoreLabel.set(playerBScore)
            
            if playerBScore >= 15 {
                self.run(.wait(forDuration: 2.0)) { [weak self] in
                    self?.finishMatch()
                }
                
                play(soundFileNamed: "audio-bleep-down.wav")
            } else {
                self.run(.wait(forDuration: 0.5)) { [weak self] in
                    self?.replayMatch(winner: .playerB)
                }
                
                play(soundFileNamed: "audio-bleep-down.wav")
            }
            
            ball.resetVelocity()
        } else if bodyA == playerBHoleBody && bodyB == ballBody || bodyA == ballBody && bodyB == playerBHoleBody {
            playerAScore += 1
            playerAScoreLabel.set(playerAScore)
            
            if playerAScore >= 15 {
                self.run(.wait(forDuration: 2.0)) { [weak self] in
                    self?.finishMatch()
                }
                
                play(soundFileNamed: "audio-bleep-up.wav")
            } else {
                self.run(.wait(forDuration: 0.5)) { [weak self] in
                    self?.replayMatch(winner: .playerA)
                }
                
                play(soundFileNamed: "audio-bleep-up.wav")
            }
            
            ball.resetVelocity()
        }
    }
    
}

