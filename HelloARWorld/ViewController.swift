//
//  ViewController.swift
//  HelloARWorld
//
//  Created by Thuc Nhi Le on 5/15/18.
//  Copyright © 2018 Thuc Nhi Le. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import OpenGLES




extension SCNNode {
    static func createLineNode(fromNode: SCNNode, toNode: SCNNode, color: UIColor) -> SCNNode {
        let line = lineFrom(vector: fromNode.position, toVector: toNode.position)
        let lineNode = SCNNode(geometry: line)
        let planeMaterial = SCNMaterial()
        planeMaterial.diffuse.contents = color
        line.materials = [planeMaterial]
        return lineNode
    }
    
    static func lineFrom(vector vector1: SCNVector3, toVector vector2: SCNVector3)-> SCNGeometry {
        let indices: [Int32] = [0, 1]
        let source = SCNGeometrySource(vertices: [vector1, vector2])
        let element = SCNGeometryElement(indices: indices, primitiveType: .line)
        return SCNGeometry(sources: [source], elements: [element])
    }
}


class ViewController: UIViewController, ARSCNViewDelegate {

   
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/


        
    // Add cube to scene at (0,0,0)
    @IBAction func addCube(_ sender: UIButton) {
        let width = CGFloat(0.1)
        let height = CGFloat(0.1)
        let length = CGFloat(0.1)
        let x = CGFloat(0)
        let y = CGFloat(0)
        let z = CGFloat(0)
//        // Create the layer
//        let layer = CALayer()
//        layer.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
//        layer.backgroundColor = UIColor.white.cgColor
//        layer.borderColor = UIColor.red.cgColor
//        layer.borderWidth = 5
//
//        // Create a material from the layer and assign it
//        let material = SCNMaterial()
//        material.diffuse.contents = layer
//        material.isDoubleSided = true

        
        let node = SCNNode()
        node.geometry = SCNBox(width: width, height: height, length: length, chamferRadius: 0)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        //node.geometry?.materials = [material]
        node.position = SCNVector3(x,y,z)
        self.sceneView.scene.rootNode.addChildNode(node)

        // front
        drawLineWithStroke(x1: x, y1: y-height/2, z1: z+length/2, x2: x, y2: y+height/2, z2: z+length/2, w: 0.001, h: height, l: 0.001)


        // back
        drawLineWithStroke(x1: x, y1: y-height/2, z1: z-length/2, x2: x, y2: y+height/2, z2: z-length/2, w: 0.001, h: height, l: 0.001)

        // top
        drawLineWithStroke(x1: x, y1: y+height/2, z1: z-length/2, x2: x, y2: y+height/2, z2: z+length/2, w: 0.001, h: 0.001, l: length)

        // bottom
        drawLineWithStroke(x1: x, y1: y-height/2, z1: z-length/2, x2: x, y2: y-height/2, z2: z+length/2, w: 0.001, h: 0.001, l: length)

    }
    

    @IBAction func recolorCube(_ sender: UIButton) {

        if (!self.sceneView.scene.rootNode.childNodes.isEmpty){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01){
                let node = self.sceneView.scene.rootNode.childNodes[0]
                let color = node.geometry?.firstMaterial?.diffuse.contents
                if ( UIColor.white.isEqual(color)){
                    node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
                } else {
                    node.geometry?.firstMaterial?.diffuse.contents = UIColor.white
                }
            }
        }
    }

  
    // Remove existing node
    @IBAction func removeCube(_ sender: UIButton) {
        if (!self.sceneView.scene.rootNode.childNodes.isEmpty){
            self.sceneView.scene.rootNode.childNodes[0].removeFromParentNode()
        }
//        drawPlane6()
    }
    
    
    @IBAction func addTorus(_ sender: UIButton) {
        // variables
        let width = CGFloat(0.1)
        let height = CGFloat(0.1)
        let length = CGFloat(0.1)
        let x = CGFloat(0)
        let y = CGFloat(0)
        let z = CGFloat(0)
        let r = CGFloat(0.001)
      
        // plane
        let node = SCNNode()
        node.geometry = SCNPlane(width: width, height: height)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        node.position = SCNVector3(x,y,z)
        self.sceneView.scene.rootNode.addChildNode(node)
        
        // first line
        drawLine(x1: x-width/2, y1: y-width/2, z1: z, x2: x, y2: y+width/2, z2: z, w: width, h: height, l: length)

        // second line
        drawLine(x1: x, y1: y-width/2, z1: z, x2: x+width/2, y2: y+width/2, z2: z, w: width, h: height, l: length)
        
        movingParticle(r: r, x: x, y: y, z: z, width: width, height: height, duration: 1.5)
        movingParticle(r: r, x: x+width/2, y: y, z: z, width: width, height: height, duration: 1.5)

        
        

    }
    
    // Draw normal line
    func drawLine(x1:CGFloat,y1:CGFloat,z1:CGFloat,x2:CGFloat,y2:CGFloat,z2:CGFloat,w:CGFloat,h:CGFloat,l:CGFloat){

        let start = SCNNode()
        let end = SCNNode()
        start.position = SCNVector3(x1,y1,z1)
        end.position = SCNVector3(x2,y2,z2)
        let linenode = SCNNode.createLineNode(fromNode: start, toNode: end, color: UIColor.black)
        self.sceneView.scene.rootNode.addChildNode(linenode)
        

    }
    
    // Draw line using Box
    func drawLineWithStroke(x1:CGFloat,y1:CGFloat,z1:CGFloat,x2:CGFloat,y2:CGFloat,z2:CGFloat,
                            w:CGFloat,h:CGFloat,l:CGFloat){
        
        let node = SCNNode()
        node.geometry = SCNBox(width: w, height: h, length: l, chamferRadius: 0)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.black
        node.position = SCNVector3(x1/2+x2/2,y1/2+y2/2,z1/2+z2/2)
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    // Draw line using bezierPath
    func drawLineWithStroke2(x1:CGFloat,y1:CGFloat,z1:CGFloat,x2:CGFloat,y2:CGFloat,z2:CGFloat,
                             w:CGFloat,h:CGFloat,l:CGFloat){
        let path = UIBezierPath()
        path.move(to: CGPoint(x: x1, y: y1))
        path.addLine(to: CGPoint(x: x2, y: y2))
        let node = SCNNode()
        node.geometry = SCNShape(path: path, extrusionDepth: 0.002)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.black
        node.position = SCNVector3(x1/2+x2/2,y1/2+y2/2,z1/2+z2/2)
        self.sceneView.scene.rootNode.addChildNode(node)
        
    }
    
    func movingParticle(r: CGFloat, x: CGFloat, y:CGFloat, z:CGFloat, width: CGFloat, height: CGFloat, duration: Double){
        // particle
        let particle = SCNNode()
        particle.geometry = SCNSphere(radius: r)
        particle.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        particle.position = SCNVector3(x-width/4,y,z)
        self.sceneView.scene.rootNode.addChildNode(particle)
        
        // moving
        let moveUp = SCNAction.move(to: SCNVector3(x-width/2,y-width/2,0), duration: duration)
        moveUp.timingMode = .easeInEaseOut;
        let moveDown = SCNAction.move(to: SCNVector3(x,y+width/2,0), duration: duration)
        moveDown.timingMode = .easeInEaseOut;
        let moveSequence = SCNAction.sequence([moveUp,moveDown])
        let moveLoop = SCNAction.repeatForever(moveSequence)
        particle.runAction(moveLoop)
    }
    
    func drawPlane6(){
        // variables
        let r = CGFloat(0.1) //0.1
        let pieces = 360
        let height = CGFloat(0.05) //0.05
        let p = CGFloat.pi //3.14
        let w = (2*r*p)/CGFloat(pieces) //width 0.1046
        let length = CGFloat(0.05)

        // plane
        firstQuadrant(w: w, height: height, pieces: pieces,length: length, r: r, p: p)
        secondQuadrant(w: w, height: height, pieces: pieces, length: length, r: r, p: p)
        thirdQuadrant(w: w, height: height, pieces: pieces, length: length, r: r, p: p)
        fourthQuadrant(w: w, height: height, pieces: pieces, length: length, r: r, p: p)

    }
    
    func fourthQuadrant(w: CGFloat, height: CGFloat, pieces: Int, length: CGFloat, r:CGFloat, p:CGFloat){
        var i = CGFloat(pieces/2)
        i = i-1
        for _ in 1...pieces/4 {
            let node = SCNNode()
            node.geometry = SCNBox(width: w, height: height, length: length, chamferRadius: 0)
            node.geometry?.firstMaterial?.diffuse.contents = UIColor.white
            node.position = SCNVector3(r*CGFloat(sin(i*p/CGFloat(pieces))),0,r*CGFloat(cos(i*p/CGFloat(pieces))))
            node.eulerAngles = SCNVector3(0,i*p/CGFloat(pieces),0)
            self.sceneView.scene.rootNode.addChildNode(node)
            i = i-2
        }
    }
    
    func firstQuadrant(w: CGFloat, height: CGFloat, pieces: Int, length: CGFloat, r:CGFloat, p:CGFloat){
        var i = CGFloat(pieces/2)
        i = i-1
        for _ in 1...pieces/4 {
            let node = SCNNode()
            node.geometry = SCNBox(width: w, height: height, length: length, chamferRadius: 0)
            node.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
            node.position = SCNVector3(r*CGFloat(sin(i*p/CGFloat(pieces))),0,-r*CGFloat(cos(i*p/CGFloat(pieces))))
            node.eulerAngles = SCNVector3(0,-i*p/CGFloat(pieces),0)
            self.sceneView.scene.rootNode.addChildNode(node)
            i = i-2
        }
    }

    func thirdQuadrant(w: CGFloat, height: CGFloat, pieces: Int, length: CGFloat, r:CGFloat, p:CGFloat){
        var i = CGFloat(pieces/2)
        i = i-1
        for _ in 1...pieces/4 {
            let node = SCNNode()
            node.geometry = SCNBox(width: w, height: height, length: length, chamferRadius: 0)
            node.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
            node.position = SCNVector3(-r*CGFloat(sin(i*p/CGFloat(pieces))),0,r*CGFloat(cos(i*p/CGFloat(pieces))))
            node.eulerAngles = SCNVector3(0,-i*p/CGFloat(pieces),0)
            self.sceneView.scene.rootNode.addChildNode(node)
            i = i-2
        }
    }
    
    func secondQuadrant(w: CGFloat, height: CGFloat, pieces: Int, length: CGFloat, r:CGFloat, p:CGFloat){
        var i = CGFloat(pieces/2)
        i = i-1
        for _ in 1...pieces/4 {
            let node = SCNNode()
            node.geometry = SCNBox(width: w, height: height, length: length, chamferRadius: 0)
            node.geometry?.firstMaterial?.diffuse.contents = UIColor.white
            node.position = SCNVector3(-r*CGFloat(sin(i*p/CGFloat(pieces))),0,-r*CGFloat(cos(i*p/CGFloat(pieces))))
            node.eulerAngles = SCNVector3(0,i*p/CGFloat(pieces),0)
            self.sceneView.scene.rootNode.addChildNode(node)
            i = i-2
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
