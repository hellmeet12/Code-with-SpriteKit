//
//  GameScene.swift
//  Code With SpriteKit
//
//  Created by Rizki Samudra on 29/05/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var sampleImage : SKSpriteNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        //be sure to change the ZPosition of the node atleast to 1, so it can be detected by touches
        label?.zPosition = 1
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
        
        //be sure to add name of the node, so it can be record when touches
        self.sampleImage = self.childNode(withName: "//sampleImage") as? SKSpriteNode
        
        //be sure to change the ZPosition of the node atleast to 1, so it can be detected by touches
        sampleImage?.zPosition = 1
        
        
        //Sample Custom Label with Programmaticaly code
        var label2 = SKLabelNode(text: "Hello Everyone")
        label2.fontSize = 24
        label2.zPosition = 1
        label2.name = "Label2"
        
        //because we give anchor point to 0,5 and 0,5 so we should put minus (-) so it can pas beyond x:0, and y: 0
        label2.position = CGPoint(x: 0, y: -250)
        
        //after create some node, we should add it
        addChild(label2)

    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches {
            self.touchDown(atPoint: t.location(in: self)) }

        //check if touches some node
            if let touch = touches.first {
                let touchLocationScene = touch.location(in: self)
                let canditateNode = self.atPoint(touchLocationScene)
    
                //check if touches helloLabel, if touches do some print
                if let name = canditateNode.name, name.contains("helloLabel") {
                    print("touches: \(name)")
                }
                
                //check if touches sampleImage, if touches do some print
                if let name = canditateNode.name, name.contains("sampleImage") {
                    print("touches: \(name)")
                }
                
                  
                //check if touches Label2, if touches do some print
                if let name = canditateNode.name, name.contains("Label2") {
                    print("touches: \(name)")
                }
                
                
                
            }
            
    }
    
      
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
