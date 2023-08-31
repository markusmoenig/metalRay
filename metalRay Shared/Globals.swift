//
//  Globals.swift
//  metalRay
//
//  Created by Markus Moenig on 21/8/23.
//

import Foundation

let LIGHTGRAY = Color(r: 200, g: 200, b: 200, a: 255)
let GRAY = Color(r: 130, g: 130, b: 130, a: 255)
let DARKGRAY = Color(r: 80, g: 80, b: 80, a: 255)
let YELLOW = Color(r: 253, g: 249, b: 0, a: 255)
let GOLD = Color(r: 255, g: 203, b: 0, a: 255)
let ORANGE = Color(r: 255, g: 161, b: 0, a: 255)
let PINK = Color(r: 255, g: 109, b: 194, a: 255)
let RED = Color(r: 230, g: 41, b: 55, a: 255)
let MAROON = Color(r: 190, g: 33, b: 55, a: 255)
let GREEN = Color(r: 0, g: 228, b: 48, a: 255)
let LIME = Color(r: 0, g: 158, b: 47, a: 255)
let DARKGREEN = Color(r: 0, g: 117, b: 44, a: 255)
let SKYBLUE = Color(r: 102, g: 191, b: 255, a: 255)
let BLUE = Color(r: 0, g: 121, b: 241, a: 255)
let DARKBLUE = Color(r: 0, g: 82, b: 172, a: 255)
let PURPLE = Color(r: 200, g: 122, b: 255, a: 255)
let VIOLET = Color(r: 135, g: 60, b: 190, a: 255)
let DARKPURPLE = Color(r: 112, g: 31, b: 126, a: 255)
let BEIGE = Color(r: 211, g: 176, b: 131, a: 255)
let BROWN = Color(r: 127, g: 106, b: 79, a: 255)
let DARKBROWN = Color(r: 76, g: 63, b: 47, a: 255)
let WHITE = Color(r: 255, g: 255, b: 255, a: 255)
let BLACK = Color(r: 0, g: 0, b: 0, a: 255)
let BLANK = Color(r: 0, g: 0, b: 0, a: 0)
let MAGENTA = Color(r: 255, g: 0, b: 255, a: 255)
let RAYWHITE = Color(r: 245, g: 245, b: 245, a: 255)

func float4ToColor(_ color: float4) -> Color {
    return Color(r: UInt8(color.x * 255), g: UInt8(color.y * 255), b: UInt8(color.z * 255), a: UInt8(color.w * 255))
}

func colorToFloat4(_ color: Color) -> float4 {
    return float4(Float(color.r) / 255, Float(color.g) / 255, Float(color.b) / 255, Float(color.a) / 255)
}

func vector2ToFloat2(_ v: Vector2) -> float2 {
    return float2(v.x, v.y)
}

func toCStr(string: String) -> UnsafePointer<Int8> {
    return (string as NSString).utf8String!
}
