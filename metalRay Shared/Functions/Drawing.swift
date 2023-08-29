//
//  Drawing.swift
//  metalRay
//
//  Created by Markus Moenig on 21/8/23.
//

import Foundation

@_silgen_name("BeginDrawing")
func BeginDrawing() {
    if let game = globalGame {
        game.draw2D.encodeStart()
    }
}

@_silgen_name("EndDrawing")
func EndDrawing() {
    if let game = globalGame {
        game.draw2D.encodeEnd()
    }
}

/// Clear
@_silgen_name("Clear")
func Clear(color: Color) {
    if let game = globalGame {
        
        let size = game.draw2D.viewSize
        let c = colorToFloat4(color)
        
        game.draw2D.startShape(type: .triangle)
        game.draw2D.addVertex(float2(size.x, size.y), float2(1.0, 0.0), c)
        game.draw2D.addVertex(float2(0, size.y), float2(0.0, 0.0), c)
        game.draw2D.addVertex(float2(0, 0), float2(0.0, 1.0), c)
        
        game.draw2D.addVertex(float2(size.x, size.y), float2(1.0, 0.0), c)
        game.draw2D.addVertex(float2(0, 0), float2(0.0, 1.0), c)
        game.draw2D.addVertex(float2(size.x, 0), float2(1.0, 1.0), c)
        game.draw2D.endShape()
    }
}

/// CreateTexture
@_silgen_name("CreateTexture")
func CreateTexture(width: Int, height: Int) -> Int {
    if let game = globalGame {
        if let id = game.draw2D.createTexture(width: width, height: height) {
            return id
        }
    }
    return -1
}

/// LoadTexture
@_silgen_name("LoadTexture")
func LoadTexture(name: String) -> Int {
    if let game = globalGame {
        if let id = game.draw2D.loadTexture(name) {
            print("yes")
            return id
        }
    }
    return -1
}

/// SetTarget
@_silgen_name("SetTarget")
@discardableResult func SetTarget(id: Int) -> Bool {
    if let game = globalGame {
        return game.draw2D.setTarget(id: id)
    }
    return false
}

/// SetTexture
@_silgen_name("SetTexture")
@discardableResult func SetTexture(id: Int) -> Bool {
    if let game = globalGame {
        return game.draw2D.setTexture(id: id)
    }
    return false
}

/// DrawRect
@_silgen_name("DrawRect")
func DrawRect(rect: Rectangle, color: Color) {
    if let game = globalGame {
        let c = colorToFloat4(color)
        game.draw2D.startShape(type: .triangle)
        game.draw2D.drawRect(rect, c, 0.0)
        game.draw2D.endShape()
    }
}

/// DrawRectRotCenter
@_silgen_name("DrawRectRotCenter")
func DrawRectRotCenter(rect: Rectangle, color: Color, rot: Float) {
    if let game = globalGame {
        let c = colorToFloat4(color)
        game.draw2D.startShape(type: .triangle)
        game.draw2D.drawRect(rect, c, rot)
        game.draw2D.endShape()
    }
}
