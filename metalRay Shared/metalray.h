//
//  metalray.h
//  metalRay
//
//  Created by Markus Moenig on 28/8/23.
//

#include "metalray_core.h"

#ifndef metalray_h
#define metalray_h

// Device

extern int GetScreenWidth(void);
extern int GetScreenHeight(void);

// Drawing

extern void BeginDrawing(void);
extern void EndDrawing(void);

extern void Clear(Color);

extern void DrawRectRotCenter(Rectangle rect, Color color, float rot);

extern void SetFont(char *fontname);
extern Vector2 GetFontSize(char *text, float size);
extern void DrawText(Vector2 pos, char *text, float size, Color color);

// Textures

extern int LoadTexture(char *texture);

extern int SetTexture(int id);

#endif /* metalray_h */
