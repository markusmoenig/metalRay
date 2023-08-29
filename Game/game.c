//
//  main.c
//  metalRay
//
//  Created by Markus Moenig on 21/8/23.
//

#include <stdio.h>
#include <metalray.h>

int textureId;
float rot = 0.0;

void InitGame(void) {
    textureId = LoadTexture("Test");
}

void UpdateGame(void) {
    
    rot += 1.0;
    
    BeginDrawing();
    Clear(ORANGE);
    
    SetTexture(textureId);
    DrawRectRotCenter((Rectangle){100, 100, 400, 400}, GREEN, rot);
    SetTexture(0);
    EndDrawing();
}

void DeinitGame(void) {
}
