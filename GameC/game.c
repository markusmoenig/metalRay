//
//  main.c
//  metalRay
//
//  Created by Markus Moenig on 21/8/23.
//

#include <stdio.h>

#include <raylib.h>

int Update(void) {
    
    BeginDrawing();
    ClearBackground(RAYWHITE);
    
    DrawRectangle(50, 50, 200, 200, ORANGE);
    
    EndDrawing();
    
    return 0;
}
