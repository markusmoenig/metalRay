//
//  RayMTKView.swift
//  metalRay
//
//  Created by Markus Moenig on 21/8/23.
//

import SwiftUI
import MetalKit

public class RayView       : MTKView
{
    var game                : Game!

    var keysDown            : [Float] = []
    
    var mouseIsDown         : Bool = false
    var mousePos            = float2(0, 0)
    
    var hasTap              : Bool = false
    var hasDoubleTap        : Bool = false
    
    var buttonDown          : String? = nil
    var swipeDirection      : String? = nil

    func reset()
    {
        keysDown = []
        mouseIsDown = false
        hasTap  = false
        hasDoubleTap  = false
        buttonDown = nil
        swipeDirection = nil
    }

    #if os(OSX)
    
    // --- Key States
    var shiftIsDown     : Bool = false
    var commandIsDown   : Bool = false
        
    override public var acceptsFirstResponder: Bool { return true }
    
    func platformInit() {
    }
    
    /// To get continuous mouse events on macOS
    override public func updateTrackingAreas()
    {
        let options : NSTrackingArea.Options = [.mouseEnteredAndExited, .mouseMoved, .activeInKeyWindow]
        let trackingArea = NSTrackingArea(rect: self.bounds, options: options,
                                      owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
    }
    
    func setMousePos(_ event: NSEvent)
    {
        var location = event.locationInWindow
        location.y = location.y - CGFloat(frame.height)
        location = convert(location, from: nil)
        
        mousePos.x = Float(location.x)
        mousePos.y = -Float(location.y)
    }
    
    override public func keyDown(with event: NSEvent)
    {
        keysDown.append(Float(event.keyCode))
    }
    
    override public func keyUp(with event: NSEvent)
    {
        keysDown.removeAll{$0 == Float(event.keyCode)}
    }
        
    override public func mouseDown(with event: NSEvent) {
        if game.state == .Running {
            if event.clickCount == 2 {
                hasDoubleTap = true
            } else {
                mouseIsDown = true
                setMousePos(event)
            }
        } else
        if game.state == .Idle {
            /*
            if let asset = game.assetFolder.current, asset.type == .Map {
                setMousePos(event)
                game.mapBuilder.mapPreview.mouseDown(mousePos.x, mousePos.y)
            }*/
        }
    }
    
    override public func mouseDragged(with event: NSEvent) {
        if game.state == .Running && mouseIsDown {
            setMousePos(event)
        }
        
        if game.state == .Idle {
            /*
            if let asset = game.assetFolder.current, asset.type == .Map {
                setMousePos(event)
                game.mapBuilder.mapPreview.mouseDown(mousePos.x, mousePos.y)
            }*/
        }
    }
    
    override public func mouseUp(with event: NSEvent) {
        if game.state == .Running {
            mouseIsDown = false
            hasTap = false
            hasDoubleTap = false
            setMousePos(event)
        }
    }
    
    override public func flagsChanged(with event: NSEvent) {
        //https://stackoverflow.com/questions/9268045/how-can-i-detect-that-the-shift-key-has-been-pressed
        if game.state == .Idle {
            if event.modifierFlags.contains(.shift) {
                shiftIsDown = true
            } else {
                shiftIsDown = false
            }
            if event.modifierFlags.contains(.command) {
                commandIsDown = true
            } else {
                commandIsDown = false
            }
        }
    }
    
    override public func scrollWheel(with event: NSEvent) {
        if game.state == .Idle {
            //game.mapBuilder.mapPreview.scrollWheel(with: event)
        }
    }
    #elseif os(iOS)
    
    func platformInit()
    {
        let tapRecognizer = UITapGestureRecognizer(target: self, action:(#selector(self.handleTapGesture(_:))))
        tapRecognizer.numberOfTapsRequired = 1
        addGestureRecognizer(tapRecognizer)
        
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action:(#selector(self.handlePinchGesture(_:))))
        addGestureRecognizer(pinchRecognizer)
    }
    
    var lastPinch : Float = 1
    
    @objc func handlePinchGesture(_ recognizer: UIPinchGestureRecognizer)
    {
        if game.state == .Idle {
            if let asset = game.assetFolder.current, asset.type == .Map {
                if let map = asset.map {
                    let pinch = Float(recognizer.scale)
                    if pinch >= lastPinch {
                        map.camera2D.zoom += pinch * 0.2
                    } else {
                        map.camera2D.zoom -= pinch * 0.2
                    }
                    lastPinch = pinch
                    map.camera2D.zoom = max(map.camera2D.zoom, 0.01)
                    game.mapBuilder.createPreview(map, true)
                }
            }
        }
    }
    
    @objc func handleTapGesture(_ recognizer: UITapGestureRecognizer)
    {
        if recognizer.numberOfTouches == 1 {
            hasTap = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 / 60.0) {
                self.hasTap = false
            }
        } else
        if recognizer.numberOfTouches >= 1 {
            hasDoubleTap = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 / 60.0) {
                self.hasDoubleTap = false
            }
        }
    }
    
    func setMousePos(_ x: Float, _ y: Float)
    {
        mousePos.x = x
        mousePos.y = y
        
        mousePos.x /= Float(bounds.width) / game.texture!.width// / game.scaleFactor
        mousePos.y /= Float(bounds.height) / game.texture!.height// / game.scaleFactor
    }
    
    var firstTouch = float2(0,0)
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mouseIsDown = true
        if let touch = touches.first {
            let point = touch.location(in: self)
            setMousePos(Float(point.x), Float(point.y))
            
            if game.state == .Idle {
                firstTouch.x = mousePos.x
                firstTouch.y = mousePos.y
                if let asset = game.assetFolder.current, asset.type == .Map {
                    if let map = asset.map {
                        let coords = map.reverseCoordinates(mousePos.x, mousePos.y)
                        game.tempText = "\(coords.x) x \(coords.y)"
                        game.tempTextChanged.send()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.game.tempText = ""
                            self.game.tempTextChanged.send()
                        }
                    }
                }
            }
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self)
            setMousePos(Float(point.x), Float(point.y))
            if game.state == .Idle {
                if let asset = game.assetFolder.current, asset.type == .Map {
                    if let map = asset.map {
                        map.camera2D.xOffset += mousePos.x - firstTouch.x
                        map.camera2D.yOffset += mousePos.y - firstTouch.y
                        
                        firstTouch.x = mousePos.x
                        firstTouch.y = mousePos.y

                        game.mapBuilder.createPreview(map, true)
                    }
                }
            }
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        mouseIsDown = false
        if let touch = touches.first {
            let point = touch.location(in: self)
                setMousePos(Float(point.x), Float(point.y))
        }
    }
    
    #elseif os(tvOS)
        
    func platformInit()
    {
        var swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
        swipeRecognizer.direction = .right
        addGestureRecognizer(swipeRecognizer)
        
        swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        swipeRecognizer.direction = .left
        addGestureRecognizer(swipeRecognizer)
        
        swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
        swipeRecognizer.direction = .up
        addGestureRecognizer(swipeRecognizer)
        
        swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown))
        swipeRecognizer.direction = .down
        addGestureRecognizer(swipeRecognizer)
    }
    
    public override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?)
    {
        guard let buttonPress = presses.first?.type else { return }
            
        switch(buttonPress) {
            case .menu:
                buttonDown = "Menu"
            case .playPause:
                buttonDown = "Play/Pause"
            case .select:
                buttonDown = "Select"
            case .upArrow:
                buttonDown = "ArrowUp"
            case .downArrow:
                buttonDown = "ArrowDown"
            case .leftArrow:
                buttonDown = "ArrowLeft"
            case .rightArrow:
                buttonDown = "ArrowRight"
            default:
                print("Unkown Button", buttonPress)
        }
    }
    
    public override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?)
    {
        buttonDown = nil
    }
    
    @objc func swipedUp() {
       swipeDirection = "up"
    }
    
    @objc func swipedDown() {
       swipeDirection = "down"
    }
        
    @objc func swipedRight() {
       swipeDirection = "right"
    }
    
    @objc func swipedLeft() {
       swipeDirection = "left"
    }

    
    #endif
}
