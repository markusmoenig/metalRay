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

@_silgen_name("ClearBackground")
func ClearBackground(color: Color) {
    if let game = globalGame {
        
        let size = game.draw2D.viewSize
        let c = colorToFloat4(color)
        game.draw2D.startShape()
        
        game.draw2D.addVertex(float2(size.x, size.y), float2(1.0, 0.0), c)
        game.draw2D.addVertex(float2(0, size.y), float2(0.0, 0.0), c)
        game.draw2D.addVertex(float2(0, 0), float2(0.0, 1.0), c)
        
        game.draw2D.addVertex(float2(size.x, size.y), float2(1.0, 0.0), c)
        game.draw2D.addVertex(float2(0, 0), float2(0.0, 1.0), c)
        game.draw2D.addVertex(float2(size.x, 0), float2(1.0, 1.0), c)

        game.draw2D.endShape(type: .triangle)
    }
}

// -- Rectangle

@_silgen_name("DrawRectangle")
func DrawRectangle(posX: Int, posY: Int, width: Int, height: Int, color: Color) {
    if let game = globalGame {
        
        //        right, bottom, 1.0, 0.0,
        //        left, bottom, 0.0, 0.0,
        //        left, top, 0.0, 1.0,
        //
        //        right, bottom, 1.0, 0.0,
        //        left, top, 0.0, 1.0,
        //        right, top, 1.0, 1.0,

        let c = colorToFloat4(color)
        game.draw2D.startShape()
        
        game.draw2D.addVertex(float2(Float(posX + width), Float(posY + height)), float2(1.0, 0.0), c)
        game.draw2D.addVertex(float2(Float(posX), Float(posY + height)), float2(0.0, 0.0), c)
        game.draw2D.addVertex(float2(Float(posX), Float(posY)), float2(0.0, 1.0), c)
        
        game.draw2D.addVertex(float2(Float(posX + width), Float(posY + height)), float2(1.0, 0.0), c)
        game.draw2D.addVertex(float2(Float(posX), Float(posY)), float2(0.0, 1.0), c)
        game.draw2D.addVertex(float2(Float(posX + width), Float(posY)), float2(1.0, 1.0), c)

        game.draw2D.endShape(type: .triangle)
    }
}

@_silgen_name("DrawRectangleLines")
func DrawRectangleLines(posX: Int, posY: Int, width: Int, height: Int, color: Color) {
    if let game = globalGame {

        let c = colorToFloat4(color)
        game.draw2D.startShape()
        
        game.draw2D.addVertex(float2(Float(posX + 1), Float(posY + 1)), float2(0.0, 1.0), c)
        game.draw2D.addVertex(float2(Float(posX + width), Float(posY + 1)), float2(1.0, 1.0), c)
        game.draw2D.addVertex(float2(Float(posX + width), Float(posY + height)), float2(1.0, 0.0), c)
        game.draw2D.addVertex(float2(Float(posX + 1), Float(posY + height)), float2(0.0, 0.0), c)
        game.draw2D.addVertex(float2(Float(posX + 1), Float(posY + 1)), float2(0.0, 1.0), c)

        game.draw2D.endShape(type: .lineStrip)
    }
}

@_silgen_name("DrawRectangleGradientH")
func DrawRectangleGradientH(posX: Int, posY: Int, width: Int, height: Int, color1: Color, color2: Color) {
    if let game = globalGame {
    
        let c1 = colorToFloat4(color1)
        let c2 = colorToFloat4(color2)

        game.draw2D.startShape()
        
        game.draw2D.addVertex(float2(Float(posX + width), Float(posY + height)), float2(1.0, 0.0), c2)
        game.draw2D.addVertex(float2(Float(posX), Float(posY + height)), float2(0.0, 0.0), c1)
        game.draw2D.addVertex(float2(Float(posX), Float(posY)), float2(0.0, 1.0), c1)
        
        game.draw2D.addVertex(float2(Float(posX + width), Float(posY + height)), float2(1.0, 0.0), c2)
        game.draw2D.addVertex(float2(Float(posX), Float(posY)), float2(0.0, 1.0), c1)
        game.draw2D.addVertex(float2(Float(posX + width), Float(posY)), float2(1.0, 1.0), c2)

        game.draw2D.endShape(type: .triangle)
    }
}

@_silgen_name("DrawRectangleGradientV")
func DrawRectangleGradientV(posX: Int, posY: Int, width: Int, height: Int, color1: Color, color2: Color) {
    if let game = globalGame {
    
        let c1 = colorToFloat4(color1)
        let c2 = colorToFloat4(color2)

        game.draw2D.startShape()
        
        game.draw2D.addVertex(float2(Float(posX + width), Float(posY + height)), float2(1.0, 0.0), c2)
        game.draw2D.addVertex(float2(Float(posX), Float(posY + height)), float2(0.0, 0.0), c2)
        game.draw2D.addVertex(float2(Float(posX), Float(posY)), float2(0.0, 1.0), c1)
        
        game.draw2D.addVertex(float2(Float(posX + width), Float(posY + height)), float2(1.0, 0.0), c2)
        game.draw2D.addVertex(float2(Float(posX), Float(posY)), float2(0.0, 1.0), c1)
        game.draw2D.addVertex(float2(Float(posX + width), Float(posY)), float2(1.0, 1.0), c1)

        game.draw2D.endShape(type: .triangle)
    }
}

// -- Line

@_silgen_name("DrawLine")
func DrawLine(startPosX: Int, startPosY: Int, endPosX: Int, endPosY: Int, color: Color) {
    if let game = globalGame {

        let c = colorToFloat4(color)
        game.draw2D.startShape()
        
        game.draw2D.addVertex(float2(Float(startPosX), Float(startPosY)), float2(0.0, 0.0), c)
        game.draw2D.addVertex(float2(Float(endPosX), Float(endPosY)), float2(1.0, 1.0), c)

        game.draw2D.endShape(type: .lineStrip)
    }
}

// -- Triangle

@_silgen_name("DrawTriangle")
func DrawTriangle(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) {
    if let game = globalGame {

        let c = colorToFloat4(color)
        game.draw2D.startShape()
        
        game.draw2D.addVertex(vector2ToFloat2(v1), float2(0.0, 0.0), c)
        game.draw2D.addVertex(vector2ToFloat2(v2), float2(0.0, 0.0), c)
        game.draw2D.addVertex(vector2ToFloat2(v3), float2(0.0, 0.0), c)

        game.draw2D.endShape(type: .triangle)
    }
}

@_silgen_name("DrawTriangleLines")
func DrawTriangleLines(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) {
    if let game = globalGame {

        let c = colorToFloat4(color)
        game.draw2D.startShape()
        
        game.draw2D.addVertex(vector2ToFloat2(v1), float2(0.0, 0.0), c)
        game.draw2D.addVertex(vector2ToFloat2(v2), float2(0.0, 0.0), c)
        game.draw2D.addVertex(vector2ToFloat2(v3), float2(0.0, 0.0), c)
        game.draw2D.addVertex(vector2ToFloat2(v1), float2(0.0, 0.0), c)

        game.draw2D.endShape(type: .lineStrip)
    }
}

// -- Poly

@_silgen_name("DrawPoly")
    func DrawPoly(center: Vector2, sides: Int, radius: Float, rotation: Float, color: Color) {
    if let game = globalGame {

        let c = colorToFloat4(color)
        game.draw2D.startShape()

        var sides = sides
        if (sides < 3) { sides = 3 }
        
        var centralAngle = -rotation * Float.pi / 180.0
        let angleStep = 360.0 / Float(sides) * Float.pi / 180.0

        for _ in 0..<sides {
            
            game.draw2D.addVertex(float2(center.x, center.y), float2(0.0, 0.0), c)
            game.draw2D.addVertex(float2(center.x + cos(centralAngle + angleStep) * radius, center.y + sin(centralAngle + angleStep) * radius), float2(0.0, 0.0), c)
            game.draw2D.addVertex(float2(center.x + cos(centralAngle)*radius, center.y + sin(centralAngle)*radius), float2(0.0, 0.0), c)

            centralAngle += angleStep;
        }
        
        game.draw2D.endShape(type: .triangle)
    }
}

@_silgen_name("DrawPolyLines")
    func DrawPolyLines(center: Vector2, sides: Int, radius: Float, rotation: Float, color: Color) {
    if let game = globalGame {

        let c = colorToFloat4(color)
        game.draw2D.startShape()

        var sides = sides
        if (sides < 3) { sides = 3 }
        
        var centralAngle = -rotation * Float.pi / 180.0
        let angleStep = 360.0 / Float(sides) * Float.pi / 180.0

        for _ in 0..<sides {
            
            game.draw2D.addVertex(float2(center.x + cos(centralAngle)*radius, center.y + sin(centralAngle)*radius), float2(0.0, 0.0), c)
            game.draw2D.addVertex(float2(center.x + cos(centralAngle + angleStep) * radius, center.y + sin(centralAngle + angleStep) * radius), float2(0.0, 0.0), c)

            centralAngle += angleStep;
        }
        
        game.draw2D.endShape(type: .line)
    }
}

@_silgen_name("DrawPolyLinesEx")
func DrawPolyLinesEx(center: Vector2, sides: Int, radius: Float, rotation: Float, lineThick: Float, color: Color) {
    if let game = globalGame {

        let c = colorToFloat4(color)
        game.draw2D.startShape()

        var sides = sides
        if (sides < 3) { sides = 3 }
        
        var centralAngle = -rotation * Float.pi / 180.0
        let exteriorAngle = 360.0 / Float(sides) * Float.pi / 180.0
        let innerRadius = radius - (lineThick*cosf(Float.pi / 180.0*exteriorAngle/2.0));

        for _ in 0..<sides {
            
            let nextAngle = centralAngle + exteriorAngle;

            game.draw2D.addVertex(float2(center.x + cos(nextAngle)*radius, center.y + sin(nextAngle)*radius), float2(0.0, 0.0), c)
            game.draw2D.addVertex(float2(center.x + cos(centralAngle)*radius, center.y + sin(centralAngle)*radius), float2(0.0, 0.0), c)
            game.draw2D.addVertex(float2(center.x + cos(centralAngle)*innerRadius, center.y + sin(centralAngle)*innerRadius), float2(0.0, 0.0), c)

            game.draw2D.addVertex(float2(center.x + cos(centralAngle)*innerRadius, center.y + sin(centralAngle)*innerRadius), float2(0.0, 0.0), c)
            game.draw2D.addVertex(float2(center.x + cos(nextAngle)*innerRadius, center.y + sin(nextAngle)*innerRadius), float2(0.0, 0.0), c)
            game.draw2D.addVertex(float2(center.x + cos(nextAngle)*radius, center.y + sin(nextAngle)*radius), float2(0.0, 0.0), c)

            centralAngle = nextAngle;
        }
        
        game.draw2D.endShape(type: .triangle)
    }
}

// -- Circle

@_silgen_name("DrawCircle")
func DrawCircle(centerX: Int, centerY: Int, radius: Float, color: Color) {
    DrawCircleV(center: Vector2(x: Float(centerX), y: Float(centerY)), radius: radius, color: color)
}

@_silgen_name("DrawCircleV")
func DrawCircleV(center: Vector2, radius: Float, color: Color) {
    DrawCircleSector(center: center, radius: radius, startAngle: 0, endAngle: 360, segments: 36, color: color);
}

@_silgen_name("DrawCircleSector")
func DrawCircleSector(center: Vector2, radius: Float, startAngle: Float, endAngle: Float, segments: Int, color: Color) {
    var radius = radius
    if radius <= 0.0 { radius = 0.1 }  // Avoid div by zero
    
    var startAngle = startAngle
    var endAngle = endAngle
    var segments = segments
    
    // Function expects (endAngle > startAngle)
    if endAngle < startAngle {
        // Swap values
        let tmp = startAngle;
        startAngle = endAngle;
        endAngle = tmp;
    }
    
    let minSegments = Int(ceil((endAngle - startAngle)/90))

    if segments < minSegments {
        // Calculate the maximum angle between segments based on the error rate (usually 0.5f)
        let th = acos(2*pow(1 - 0.5/radius, 2) - 1);
        segments = Int((endAngle - startAngle)*ceil(2*Float.pi/th)/360)

        if segments <= 0  {
            segments = minSegments
        }
    }

    let stepLength = (endAngle - startAngle)/Float(segments)
    var angle = startAngle
    
    let DEG2RAD = Float.pi / 180.0
    
    
    if let game = globalGame {
        
        let c = colorToFloat4(color)
        game.draw2D.startShape()

        for _ in 0..<segments {
            game.draw2D.addVertex(float2(center.x, center.y), float2(0.0, 0.0), c)
            game.draw2D.addVertex(float2(center.x + cos(DEG2RAD * (angle + stepLength)) * radius, center.y + sin(DEG2RAD * (angle + stepLength)) * radius), float2(0.0, 0.0), c)
            game.draw2D.addVertex(float2(center.x + cos(DEG2RAD * angle) * radius, center.y + sin(DEG2RAD * angle) * radius), float2(0.0, 0.0), c)

            angle += stepLength
        }
        
        game.draw2D.endShape(type: .triangle)
    }
}
