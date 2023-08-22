//
//  Core.swift
//  metalRay
//
//  Created by Markus Moenig on 22/8/23.
//

import Foundation

@_silgen_name("GetScreenWidth")
func GetScreenWidth() -> Int {
    if let game = globalGame {
        return Int(game.draw2D.viewSize.x)
    }
    return 0;
}

@_silgen_name("GetScreenHeight")
func GetScreenHeight() -> Int {
    if let game = globalGame {
        return Int(game.draw2D.viewSize.y)
    }
    return 0;
}
