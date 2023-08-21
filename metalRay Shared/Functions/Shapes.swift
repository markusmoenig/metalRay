//
//  Shapes.swift
//  metalRay
//
//  Created by Markus Moenig on 21/8/23.
//

import Foundation

@_silgen_name("ClearBackground")
func ClearBackground(color: Color) {
    if let game = globalGame {
        game.drawables.drawBox(position: float2(0, 0), size: game.drawables.viewSize, fillColor: colorToFloat4(color))
    }
}

@_silgen_name("DrawRectangle")
func DrawRectangle(posX: Int, posY: Int, width: Int, height: Int, color: Color) {
    if let game = globalGame {
        game.drawables.drawBox(position: float2(Float(posX), Float(posY)), size: float2(Float(width), Float(height)), fillColor: colorToFloat4(color))
    }
}
