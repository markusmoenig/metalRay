//
//  main.swift
//  metalRay
//
//  Created by Markus Moenig on 21/8/23.
//

import Foundation

var textureId : Int = -1
var rot : Float = 0.0

func initGame() {
    // Call the C Init, remove if not needed
    InitGame();
    
    //textureId = LoadTexture(name: ("Test" as NSString).utf8String!)
//    textureId = CreateTexture(width: 400, height: 400)
}

func updateGame() {
    
    // Call the C Update, remove if not needed
    UpdateGame();
    
//    SetTarget(id: textureId)
//    BeginDrawing()
//    Clear(color: YELLOW)
//    DrawRect(rect: Rectangle(x: 100, y: 200, width: 200, height: 200), color: BLUE, rot: 0.0)
//    EndDrawing()
//    SetTarget(id: 0)
    
//    rot += 1
//    BeginDrawing()
//    Clear(color: ORANGE)
//    SetTexture(id: textureId)
//    DrawRectRotCenter(rect: Rectangle(x: 100, y: 100, width: 400, height: 400), color: GREEN, rot: rot)
//    SetTexture(id: 0)
//    EndDrawing()
}

func deinitGame() {
    // Call the C Deinit, remove if not needed
    DeinitGame();
}
