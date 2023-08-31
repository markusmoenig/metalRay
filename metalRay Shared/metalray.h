//
//  metalray.h
//  metalRay
//
//  Created by Markus Moenig on 28/8/23.
//

#include "metalray_core.h"

#ifndef metalray_h
#define metalray_h

#include <stdbool.h>

// Device

extern Vector2 GetScreenSize(void);

extern bool HasTouch(void);
extern bool HasTap(void);
extern bool HasDoubleTap(void);
extern bool HasTouchEnded(void);
extern Vector2 GetTouchPos(void);

// Drawing

extern void BeginDrawing(void);
extern void EndDrawing(void);

extern void Clear(Color);

extern void DrawRect(Rectangle rect, Color color);
extern void DrawRectRotCenter(Rectangle rect, Color color, float rot);

extern void SetFont(char *fontname);
extern Vector2 GetFontSize(char *text, float size);
extern void DrawText(Vector2 pos, char *text, float size, Color color);

// Textures

extern int CreateTexture(int width, int height);

extern int LoadTexture(char *texture);

extern bool SetTexture(int id);
extern bool SetTarget(int id);

#endif /* metalray_h */
