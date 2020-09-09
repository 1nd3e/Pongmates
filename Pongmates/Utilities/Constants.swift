//
//  BitMaskCategory.swift
//  Pongmates
//
//  Created by Vladislav Kulikov on 15.05.2020.
//  Copyright © 2020 Vladislav Kulikov. All rights reserved.
//

import UIKit

enum RacketType {
    case nimbler, keeper, winger
}

enum PlayerType {
    case playerA, playerB
}

struct Screen {
    static let size = UIScreen.main.nativeBounds
}

struct BitMaskCategory {
    static let playerA: UInt32 = 1
    static let playerB: UInt32 = 2
    static let playerAHole: UInt32 = 4
    static let playerBHole: UInt32 = 8
    static let ball: UInt32 = 16
}
