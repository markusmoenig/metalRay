
## metalRay

**metalRay** is a bare bones game framework for the Apple ecosystem. If you want to code games close to the Metal with a convenient API (in the tradition of frameworks like [raylib](https://raylib.com))  you will feel right at home.

You can write games in Swift and in C directly in Xcode while being able to create C style interoperable memory structures and pass them to your Metal shaders.

*metalRay* focuses right now on 2D drawing, 3D support will be integrated once 2D is stable.

## Features

* Use drawing functions, textures and shaders with an easy to use API.
* Share memory (C style structs) between Swift, C and Metal.
* System device events can be easily queried in the game update functions.
* Draw text using SDF textures.
* Support for 2D physics and Tiled are incoming.
* Games / Apps can be deployed easily to macOS, iOS and tvOS using Xcode.

## Why ?

I like to write games low level, and all the popular convenience frameworks out there (SDL2, raylib etc.) are not based on Metal but OpenGL, which makes iOS and tvOS compatibility problematic.

And being nostalgic, I also really enjoy coding in C again sometimes. Especially for implementing some of the classics. Get your hands dirty!

Being able to deploy your games easily to macOS, iOS and tvOS is a major advantage compared to the mostly limited cross-platform alternatives.

## How to use

Fork this repository and open the Xcode project. All game related functions are inside the **Game** folder

* **game.swift**. The Swift based game entry point. Use the initGame(), updateGame() and deinitGame() functons.

* **game.c** The corresponding C file with InitGame(), UpdateGame() and DeinitGame().

* **header.h**. Implement C like structures here. These structures can be used in Swift and C as well as in Metal.

By default the Swift functions are called. If you want to implement (or mix) with the C code, call the C functions from there. See the example default code.

Place all your resources somewhere in the *Game* folder.

The Xcode project contains targets for macOS, iOS and tvOS.

I will soon add some Swift and C examples to the project.

## Status

- [x] Render Targets
- [x] Textures
- [x] Rectangle Drawing
- [ ] SDF based Shapes
- [ ] Custom Shaders
- [ ] 2D Physics
- [ ] Tiled Import
- [ ] 3D Support

---

## Structures used in the API

Loaned from raylib.

```c
// Color, 4 components, R8G8B8A8 (32bit)
typedef struct Color {
    unsigned char r;        // Color red value
    unsigned char g;        // Color green value
    unsigned char b;        // Color blue value
    unsigned char a;        // Color alpha value
} Color;

// Vector2, 2 components
typedef struct Vector2 {
    float x;                // Vector x component
    float y;                // Vector y component
} Vector2;

// Vector3, 3 components
typedef struct Vector3 {
    float x;                // Vector x component
    float y;                // Vector y component
    float z;                // Vector z component
} Vector3;

// Vector4, 4 components
typedef struct Vector4 {
    float x;                // Vector x component
    float y;                // Vector y component
    float z;                // Vector z component
    float w;                // Vector w component
} Vector4;

// Rectangle, 4 components
typedef struct Rectangle {
    float x;                // Rectangle top-left corner position x
    float y;                // Rectangle top-left corner position y
    float width;            // Rectangle width
    float height;           // Rectangle height
} Rectangle;
```

These structures are used in the API and can be created from both Swift and C and passed to Metal shaders.

---

## Window Info

```swift
// Returns the width of the screen / device
GetScreenWidth();
// Returns the height of the screen / device
GetScreenHeight();
```

## Drawing

```swift
// Starts drawing, if you change the render target you need to end drawing to your current target first.
BeginDrawing();
// End drawing
EndDrawing();

// Sets the current font
SetFont(name: CString);
// Returns the size of the given text
GetTextSize(text: CString, size: Float) -> Vector2
// Draws the text of the given size at the given position
DrawText(pos: Vector2, text: CString, size: Float, color: Color);

// Clears the current render target in the given color
Clear(color: Color);
// Draws a rectangle of the given color
DrawRect(rect: Rectangle, color: Color);
// Draws a rotated (around its center) rectangle of the given color
DrawRectRotCenter(rect: Rectangle, color: Color, rot: Int);
// More to come
```

## Textures

```swift
// Creates an RGBA8 texture of the given width and height and returns its id. Returns -1 if unsuccessful.
CreateTexture(width: Int, height: Int) -> Int;
// Load an image in the Xcode project into a texture and returns its id. Returns -1 if unsuccessful.
LoadTexture(name: CString) -> Int;

// Makes the texture of the given id the new render target. Use 0 to switch back to the default viewport. Make sure to end and restart drawing.
SetTarget(id: Int) -> Bool;

// Makes the texture of the given id the new texture. All drawing functions will replace the color value with the interpolated texture value. Use 0 to disable texture support (needs to be called before EndDrawing() too).
SetTexture(id: Int) -> Bool;
```
