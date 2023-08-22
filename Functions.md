
A list of all currently supported functions. All functions can be called from both Swift and C. This will grow over time.

#### Core

```c
// Window-related functions
int GetScreenWidth(void);                                   // Get current screen width
int GetScreenHeight(void);                                  // Get current screen height

// Drawing-related functions
void ClearBackground(Color color);                          // Set background color (framebuffer clear color)
void BeginDrawing(void);                                    // Setup canvas (framebuffer) to start drawing
void EndDrawing(void);                                      // End canvas drawing and swap buffers (double buffering)
```

#### Shapes

```c
// Basic shapes drawing functions
//void DrawPixel(int posX, int posY, Color color);                                                   // Draw a pixel
//void DrawPixelV(Vector2 position, Color color);                                                    // Draw a pixel (Vector version)
void DrawLine(int startPosX, int startPosY, int endPosX, int endPosY, Color color);                // Draw a line
//void DrawLineV(Vector2 startPos, Vector2 endPos, Color color);                                     // Draw a line (Vector version)
//void DrawLineEx(Vector2 startPos, Vector2 endPos, float thick, Color color);                       // Draw a line defining thickness
//void DrawLineBezier(Vector2 startPos, Vector2 endPos, float thick, Color color);                   // Draw a line using cubic-bezier curves in-out
//void DrawLineBezierQuad(Vector2 startPos, Vector2 endPos, Vector2 controlPos, float thick, Color color); // Draw line using quadratic bezier curves with a control point
//void DrawLineBezierCubic(Vector2 startPos, Vector2 endPos, Vector2 startControlPos, Vector2 endControlPos, float thick, Color color); // Draw line using cubic bezier curves with 2 control points
//void DrawLineStrip(Vector2 *points, int pointCount, Color color);                                  // Draw lines sequence
void DrawCircle(int centerX, int centerY, float radius, Color color);                              // Draw a color-filled circle
void DrawCircleSector(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color);      // Draw a piece of a circle
void DrawCircleSectorLines(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color); // Draw circle sector outline
void DrawCircleGradient(int centerX, int centerY, float radius, Color color1, Color color2);       // Draw a gradient-filled circle
void DrawCircleV(Vector2 center, float radius, Color color);                                       // Draw a color-filled circle (Vector version)
void DrawCircleLines(int centerX, int centerY, float radius, Color color);                         // Draw circle outline
//void DrawEllipse(int centerX, int centerY, float radiusH, float radiusV, Color color);             // Draw ellipse
//void DrawEllipseLines(int centerX, int centerY, float radiusH, float radiusV, Color color);        // Draw ellipse outline
//void DrawRing(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color); // Draw ring
//void DrawRingLines(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color);    // Draw ring outline
void DrawRectangle(int posX, int posY, int width, int height, Color color);
void DrawRectangle(int posX, int posY, int width, int height, Color color);                        // Draw a color-filled rectangle
//void DrawRectangleV(Vector2 position, Vector2 size, Color color);                                  // Draw a color-filled rectangle (Vector version)
//void DrawRectangleRec(Rectangle rec, Color color);                                                 // Draw a color-filled rectangle
//void DrawRectanglePro(Rectangle rec, Vector2 origin, float rotation, Color color);                 // Draw a color-filled rectangle with pro parameters
void DrawRectangleGradientV(int posX, int posY, int width, int height, Color color1, Color color2);// Draw a vertical-gradient-filled rectangle
void DrawRectangleGradientH(int posX, int posY, int width, int height, Color color1, Color color2);// Draw a horizontal-gradient-filled rectangle
//void DrawRectangleGradientEx(Rectangle rec, Color col1, Color col2, Color col3, Color col4);       // Draw a gradient-filled rectangle with custom vertex colors
void DrawRectangleLines(int posX, int posY, int width, int height, Color color);                   // Draw rectangle outline
//void DrawRectangleLinesEx(Rectangle rec, float lineThick, Color color);                            // Draw rectangle outline with extended parameters
//void DrawRectangleRounded(Rectangle rec, float roundness, int segments, Color color);              // Draw rectangle with rounded edges
//void DrawRectangleRoundedLines(Rectangle rec, float roundness, int segments, float lineThick, Color color); // Draw rectangle with rounded edges outline
void DrawTriangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                                // Draw a color-filled triangle (vertex in counter-clockwise order!)
void DrawTriangleLines(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                           // Draw triangle outline (vertex in counter-clockwise order!)
//void DrawTriangleFan(Vector2 *points, int pointCount, Color color);                                // Draw a triangle fan defined by points (first vertex is the center)
//void DrawTriangleStrip(Vector2 *points, int pointCount, Color color);                              // Draw a triangle strip defined by points
void DrawPoly(Vector2 center, int sides, float radius, float rotation, Color color);               // Draw a regular polygon (Vector version)
void DrawPolyLines(Vector2 center, int sides, float radius, float rotation, Color color);          // Draw a polygon outline of n sides
void DrawPolyLinesEx(Vector2 center, int sides, float radius, float rotation, float lineThick, Color color); // Draw a polygon outline of n sides with extended parameters

```
