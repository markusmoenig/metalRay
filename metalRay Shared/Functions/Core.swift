//
//  Core.swift
//  metalRay
//
//  Created by Markus Moenig on 22/8/23.
//

import Foundation

@_silgen_name("GetScreenSize")
func GetScreenSize() -> Vector2 {
    if let game = globalGame {
        return Vector2(x: game.draw2D.viewSize.x, y: game.draw2D.viewSize.y)
    }
    return Vector2(x: 0, y: 0)
}

@_silgen_name("HasTouch")
func HasTouch() -> Bool {
    if let game = globalGame {
        return game.rayView.mouseIsDown
    }
    return false
}

@_silgen_name("GetTouchPos")
func GetTouchPos() -> Vector2 {
    if let game = globalGame {
        return Vector2(x: game.rayView.mousePos.x, y: game.rayView.mousePos.y)
    }
    return Vector2(x: 0, y: 0)
}

@_silgen_name("HasTap")
func HasTap() -> Bool {
    if let game = globalGame {
        return game.rayView.hasTap
    }
    return false
}

@_silgen_name("HasDoubleTap")
func HasDoubleTap() -> Bool {
    if let game = globalGame {
        return game.rayView.hasDoubleTap
    }
    return false
}

@_silgen_name("HasTouchEnded")
func HasTouchEnded() -> Bool {
    if let game = globalGame {
        return game.rayView.hasTouchEnded
    }
    return false
}
