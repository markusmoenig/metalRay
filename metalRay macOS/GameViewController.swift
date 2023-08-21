//
//  GameViewController.swift
//  metalRay macOS
//
//  Created by Markus Moenig on 21/8/23.
//

import Cocoa
import MetalKit

// Our macOS specific view controller
class GameViewController: NSViewController {

    var rayView             : RayView!
    var game                : Game!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let rayView = self.view as? RayView else {
            print("View attached to GameViewController is not an MTKView")
            return
        }

        // Select the device to render with.  We choose the default device
        guard let defaultDevice = MTLCreateSystemDefaultDevice() else {
            print("Metal is not supported on this device")
            return
        }

        rayView.device = defaultDevice

        guard let game = Game(view: rayView) else {
            print("Game cannot be initialized")
            return
        }
        
        game.mtkView(rayView, drawableSizeWillChange: rayView.drawableSize)
        rayView.platformInit()
        
        rayView.delegate = game
    }
}
