//
//  GameViewController.swift
//  Pongmates
//
//  Created by Vladislav Kulikov on 13.05.2020.
//  Copyright © 2020 Vladislav Kulikov. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AdMob.shared.viewController = self
        
        if let scene = GKScene(fileNamed: "StartScene") {
            if let sceneNode = scene.rootNode as? StartScene {
                if let view = self.view as! SKView? {
                    let smallScreen = Screen.size.height == 1136 ? true : false
                    
                    sceneNode.size = smallScreen ? CGSize(width: 414, height: 736) : view.bounds.size
                    sceneNode.scaleMode = .aspectFill
                    
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = true
                }
            }
        }
        
        AudioPlayer.shared.play(fileNamed: "audio-music", ofType: ".wav")
    }
    
}
