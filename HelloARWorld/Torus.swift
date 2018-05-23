//
//  Torus.swift
//  HelloARWorld
//
//  Created by Thuc Nhi Le on 5/21/18.
//  Copyright © 2018 Thuc Nhi Le. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class Torus: NSObject {
    var outerR = CGFloat()
    var innerR = CGFloat()
    var pieces: Int
    init(o: CGFloat, i: CGFloat, c: Int){
        outerR = o
        innerR = i
        pieces = c
    }
    
//    func addTorus(){
//        for _ in 1...pieces {
//            //var cv = 2*outerR*3.14
//            let node = SCNNode()
//            node.geometry = SCNPlane(width: cv/CGFloat(pieces), height: 0.1)
//            node.geometry?.firstMaterial?.diffuse.contents = UIColor.white
//            node.position = SCNVector3(0,0,0)
//        }
//    }
}


