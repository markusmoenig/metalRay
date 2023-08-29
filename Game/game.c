//
//  main.c
//  metalRay
//
//  Created by Markus Moenig on 21/8/23.
//

#include <stdio.h>
#include <metalray.h>

float rotation = 0.0;

void Update(void) {
    
    rotation += 0.2;
    
    BeginDrawing();
    Clear(ORANGE);
    EndDrawing();

    /*
    int screenWidth = GetScreenWidth();
    
    // Circle shapes and lines
    DrawCircle(screenWidth/5, 120, 35, DARKBLUE);
    DrawCircleGradient(screenWidth/5, 220, 60, GREEN, SKYBLUE);
    DrawCircleLines(screenWidth/5, 340, 80, DARKBLUE);
    
    // Rectangle shapes and lines
    DrawRectangle(screenWidth/4*2 - 60, 100, 120, 60, RED);
    DrawRectangleGradientH(screenWidth/4*2 - 90, 170, 180, 130, MAROON, GOLD);
    DrawRectangleLines(screenWidth/4*2 - 40, 320, 80, 60, ORANGE);
        
    // Triangle shapes and lines
    DrawTriangle((Vector2){ screenWidth/4.0f *3.0f, 80.0f },
                 (Vector2){ screenWidth/4.0f *3.0f - 60.0f, 150.0f },
                 (Vector2){ screenWidth/4.0f *3.0f + 60.0f, 150.0f }, VIOLET);
    
    DrawTriangleLines((Vector2){ screenWidth/4.0f*3.0f, 160.0f },
                      (Vector2){ screenWidth/4.0f*3.0f - 20.0f, 230.0f },
                      (Vector2){ screenWidth/4.0f*3.0f + 20.0f, 230.0f }, DARKBLUE);
    
    // Polygon shapes and lines
    DrawPoly((Vector2){ screenWidth/4.0f*3, 330 }, 6, 80, rotation, BROWN);
    DrawPolyLines((Vector2){ screenWidth/4.0f*3, 330 }, 6, 90, rotation, BROWN);
    DrawPolyLinesEx((Vector2){ screenWidth/4.0f*3, 330 }, 6, 85, rotation, 6, BEIGE);
    
    DrawLine(18, 42, screenWidth - 18, 42, BLACK);
     */
    //EndDrawing();
}
