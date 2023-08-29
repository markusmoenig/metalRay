//
//  Metal.h
//  metalRay
//
//  Created by Markus Moenig on 21/8/23.
//

#ifndef Metal_h
#define Metal_h

#include <simd/simd.h>

typedef struct
{
    vector_float2   screenSize;
    vector_float2   pos;
    vector_float2   size;
    float           globalAlpha;

} TextureUniform;

typedef struct
{
    vector_float4   fillColor;
    vector_float4   borderColor;
    float           radius;
    float           borderSize;
    float           rotation;
    float           onion;
    
    int             hasTexture;
    vector_float2   textureSize;
} DiscUniform;

typedef struct
{
    vector_float2   screenSize;
    vector_float2   pos;
    vector_float2   size;
    float           round;
    float           borderSize;
    vector_float4   fillColor;
    vector_float4   borderColor;
    float           rotation;
    float           onion;
    
    int             hasTexture;
    vector_float2   textureSize;
} BoxUniform;

typedef struct
{
    int             hasTexture;
} RectUniform;

typedef struct
{
    vector_float2   screenSize;
    vector_float2   offset;
    float           gridSize;
    vector_float4   backColor;
    vector_float4   gridColor;
} GridUniform;

typedef struct
{
    vector_float2   size;
    vector_float2   sp, ep;
    float           width, borderSize;
    vector_float4   fillColor;
    vector_float4   borderColor;
    
} LineUniform;

typedef struct
{
    vector_float2   size;
    vector_float2   p1, p2, p3;
    float           width, borderSize;
    vector_float4   fillColor;
    vector_float4   borderColor;
    
} BezierUniform;

typedef struct
{
    vector_float2   atlasSize;
    vector_float2   fontPos;
    vector_float2   fontSize;
    vector_float4   color;
} TextUniform;

typedef struct
{
    float           time;
    unsigned int    frame;
} MetalData;

typedef struct
{
    float           time;
    unsigned int    frame;
} NoiseData;

typedef struct
{
    vector_float2   screenSize;
    
    vector_float3   camOrigin;
    vector_float3   camCenter;
    float           camFov;

    vector_int3     tileMin;
    vector_int3     tileMax;
    vector_int3     tileSize;
    
    int             tileDensity;
    
} VoxelTileUniform;

typedef struct {
    
    // Density of the tile
    int             density;
    // World coordinate of the tile
    vector_float3   coord;
    // Number of shapes we have data for
    int             shapesCount;

} ModelerUniform;

void InitGame(void);
void UpdateGame(void);
void DeinitGame(void);

#include "metalray_core.h"
#include "../Game/header.h"

#endif /* Metal_h */
