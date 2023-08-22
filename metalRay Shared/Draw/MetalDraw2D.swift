//
//  MetalDrawables.swift
//  metalRay
//
//  Created by Markus Moenig on 21/8/23.
//

import MetalKit

extension MTLVertexDescriptor {
    static var defaultLayout: MTLVertexDescriptor {
        let vertexDescriptor = MTLVertexDescriptor()
        
        vertexDescriptor.attributes[0].format = .float2
        vertexDescriptor.attributes[0].offset = 0
        vertexDescriptor.attributes[0].bufferIndex = 0
        
        vertexDescriptor.attributes[1].format = .float2
        vertexDescriptor.attributes[1].offset = MemoryLayout<Float>.stride * 2
        vertexDescriptor.attributes[1].bufferIndex = 0
        
        vertexDescriptor.attributes[2].format = .float4
        vertexDescriptor.attributes[2].offset = MemoryLayout<Float>.stride * 4
        vertexDescriptor.attributes[2].bufferIndex = 0

        let stride = MemoryLayout<Float>.stride * 8
        vertexDescriptor.layouts[0].stride = stride
        return vertexDescriptor
    }
}

class MetalDraw2D
{
    let metalView       : RayView
    
    let device          : MTLDevice
    let commandQueue    : MTLCommandQueue!
    
    var pipelineState   : MTLRenderPipelineState! = nil
    var pipelineStateDesc : MTLRenderPipelineDescriptor! = nil

    var renderEncoder   : MTLRenderCommandEncoder! = nil

    var vertexBuffer    : MTLBuffer? = nil
    var viewportSize    : vector_uint2
    
    var commandBuffer   : MTLCommandBuffer! = nil
    
    var polyState       : MTLRenderPipelineState? = nil

    var scaleFactor     : Float
    var viewSize        = float2(0,0)
    
    var vertexData      : [Float] = []
    var vertexCount     : Int = 0
    
    var font            : Font! = nil

    init(_ metalView: RayView)
    {
        self.metalView = metalView
        #if os(iOS)
        metalView.layer.isOpaque = false
        #elseif os(macOS)
        metalView.layer?.isOpaque = false
        #endif

        device = metalView.device!
        viewportSize = vector_uint2( UInt32(metalView.bounds.width), UInt32(metalView.bounds.height) )
        commandQueue = device.makeCommandQueue()
        
        scaleFactor = metalView.game.scaleFactor
                
        if let defaultLibrary = device.makeDefaultLibrary() {

            pipelineStateDesc = MTLRenderPipelineDescriptor()
            let vertexFunction = defaultLibrary.makeFunction( name: "poly2DVertex" )
            pipelineStateDesc.vertexFunction = vertexFunction
            pipelineStateDesc.colorAttachments[0].pixelFormat = metalView.colorPixelFormat
            
            pipelineStateDesc.vertexDescriptor = MTLVertexDescriptor.defaultLayout
            
            pipelineStateDesc.colorAttachments[0].isBlendingEnabled = true
            pipelineStateDesc.colorAttachments[0].rgbBlendOperation = .add
            pipelineStateDesc.colorAttachments[0].alphaBlendOperation = .add
            pipelineStateDesc.colorAttachments[0].sourceRGBBlendFactor = .sourceAlpha
            pipelineStateDesc.colorAttachments[0].sourceAlphaBlendFactor = .sourceAlpha
            pipelineStateDesc.colorAttachments[0].destinationRGBBlendFactor = .oneMinusSourceAlpha
            pipelineStateDesc.colorAttachments[0].destinationAlphaBlendFactor = .oneMinusSourceAlpha
                        
            func createNewPipelineState(_ fragmentFunction: MTLFunction?) -> MTLRenderPipelineState?
            {
                if let function = fragmentFunction {
                    pipelineStateDesc.fragmentFunction = function
                    do {
                        let renderPipelineState = try device.makeRenderPipelineState(descriptor: pipelineStateDesc)
                        return renderPipelineState
                    } catch {
                        print( "createNewPipelineState failed" )
                        return nil
                    }
                }
                return nil
            }
            
            let function = defaultLibrary.makeFunction( name: "poly2DFragment" )
            polyState = createNewPipelineState(function)
        }
    }
    
    @discardableResult func encodeStart(_ clearColor: float4 = float4(0.125, 0.129, 0.137, 1)) -> MTLRenderCommandEncoder?
    {
        if font == nil { font = Font(name: "OpenSans", game: metalView.game) }
        
        viewportSize = vector_uint2( UInt32(metalView.bounds.width), UInt32(metalView.bounds.height) )
        viewSize = float2(Float(metalView.bounds.width), Float(metalView.bounds.height))

        commandBuffer = commandQueue.makeCommandBuffer()!
        let renderPassDescriptor = metalView.currentRenderPassDescriptor
        
//        renderPassDescriptor!.colorAttachments[0].loadAction = .clear
//        renderPassDescriptor!.colorAttachments[0].clearColor = MTLClearColor( red: Double(clearColor.x), green: Double(clearColor.y), blue: Double(clearColor.z), alpha: Double(clearColor.w))
//
        renderPassDescriptor!.colorAttachments[0].loadAction = .load
        
        if renderPassDescriptor != nil {
            renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor! )
            return renderEncoder
        }
        
        return nil
    }
    
    func encodeRun( _ renderEncoder: MTLRenderCommandEncoder, pipelineState: MTLRenderPipelineState? )
    {
        renderEncoder.setRenderPipelineState( pipelineState! )
        renderEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 6)
    }
    
    func encodeEnd()
    {
        renderEncoder?.endEncoding()
        
        guard let drawable = metalView.currentDrawable else {
            return
        }
        
        if let commandBuffer = commandBuffer {
            //commandBuffer.addCompletedHandler { cb in
            //    print("Rendering Time:", (cb.gpuEndTime - cb.gpuStartTime) * 1000)
            //}
            commandBuffer.present(drawable)
            commandBuffer.commit()
        }
    }
    
    func startShape() {
        vertexData = []
        vertexCount = 0
    }
    
    func addVertex(_ vertex: float2,_ textureCoordinate: float2,_ color: float4) {
        vertexData.append(-viewSize.x / 2.0 + vertex.x)
        vertexData.append(viewSize.y / 2.0 - vertex.y)
        vertexData.append(textureCoordinate.x)
        vertexData.append(textureCoordinate.y)
        vertexData.append(color.x)
        vertexData.append(color.y)
        vertexData.append(color.z)
        vertexData.append(color.w)
        vertexCount += 1
    }
    
    func endShape(type: MTLPrimitiveType) {
        var data = BoxUniform()

        renderEncoder.setVertexBytes(vertexData, length: vertexData.count * MemoryLayout<Float>.stride, index: 0)
        renderEncoder.setVertexBytes(&viewportSize, length: MemoryLayout<vector_uint2>.stride, index: 1)
        
        renderEncoder.setFragmentBytes(&data, length: MemoryLayout<BoxUniform>.stride, index: 0)
//        if let texture = texture {
//            renderEncoder.setFragmentTexture(texture, index: 1)
//        }
        renderEncoder.setRenderPipelineState(polyState!)
        renderEncoder.drawPrimitives(type: type, vertexStart: 0, vertexCount: vertexCount)
    }
    
    /// Draws the given text
    func drawText(position: float2, text: String, size: Float, color: float4 = float4(1,1,1,1))
    {
        func drawChar(char: BMChar, x: Float, y: Float, adjScale: Float)
        {
            var data = TextUniform()
            
            data.atlasSize.x = Float(font!.atlas!.width)
            data.atlasSize.y = Float(font!.atlas!.height)
            data.fontPos.x = char.x
            data.fontPos.y = char.y
            data.fontSize.x = char.width
            data.fontSize.y = char.height
            data.color = color

            let rect = Rect(x, y, char.width * adjScale, char.height * adjScale, scale: 1)
            let vertexData = createVertexData(rect)

            renderEncoder.setVertexBytes(vertexData, length: vertexData.count * MemoryLayout<Float>.stride, index: 0)
            renderEncoder.setVertexBytes(&viewportSize, length: MemoryLayout<vector_uint2>.stride, index: 1)

            renderEncoder.setFragmentBytes(&data, length: MemoryLayout<TextUniform>.stride, index: 0)
            renderEncoder.setFragmentTexture(font!.atlas, index: 1)

            renderEncoder.setRenderPipelineState(metalView.game.metalStates.getState(state: .DrawTextChar))
            renderEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 6)
        }
        
        if let font = font {
         
            let scale : Float = (1.0 / font.bmFont!.common.lineHeight) * size
            let adjScale : Float = scale// / 2
            
            var posX = position.x// / game.scaleFactor
            let posY = position.y// / game.scaleFactor

            for c in text {
                let bmChar = font.getItemForChar( c )
                if bmChar != nil {
                    drawChar(char: bmChar!, x: posX + bmChar!.xoffset * adjScale, y: posY + bmChar!.yoffset * adjScale, adjScale: adjScale)
                    posX += bmChar!.xadvance * adjScale;
                }
            }
        }
    }
    
    /// Gets the width of the given text
    func getTextWidth(text: String, size: Float) -> Float
    {
        if let font = font {
         
            let scale : Float = (1.0 / font.bmFont!.common.lineHeight) * size
            let adjScale : Float = scale// / 2
            
            var posX : Float = 0

            for c in text {
                let bmChar = font.getItemForChar( c )
                if bmChar != nil {
                    posX += bmChar!.xadvance * adjScale
                }
            }
            
            return posX
        }
        return 0
    }
    
    /// Creates vertex data for the given rectangle
    func createVertexData(_ rect: Rect) -> [Float]
    {
        let left: Float  = -viewSize.x / 2.0 + rect.x
        let right: Float = left + rect.width
        
        let top: Float = viewSize.y / 2.0 - rect.y
        let bottom: Float = top - rect.height

        let quadVertices: [Float] = [
            right, bottom, 1.0, 0.0,
            left, bottom, 0.0, 0.0,
            left, top, 0.0, 1.0,
            
            right, bottom, 1.0, 0.0,
            left, top, 0.0, 1.0,
            right, top, 1.0, 1.0,
        ]
        
        return quadVertices
    }
    
    /// Updates the view
    func update() {
        metalView.enableSetNeedsDisplay = true
        #if os(OSX)
        let nsrect : NSRect = NSRect(x:0, y: 0, width: metalView.frame.width, height: metalView.frame.height)
        metalView.setNeedsDisplay(nsrect)
        #else
        metalView.setNeedsDisplay()
        #endif
    }
}
