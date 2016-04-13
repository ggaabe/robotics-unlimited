//
//  MyScene.swift
//  Robotics Unlimited
//
//  Created by Gabe Garrett on 4/12/16.
//  Copyright © 2016 Gabe. All rights reserved.
//

import Foundation
import SceneKit

class MyScene : SCNScene {
    override init() {
        super.init()
//        let plane = SCNPlane(width: 1.0, height: 1.0)
//        plane.firstMaterial?.diffuse.contents = UIColor.blueColor()
//
//        let planeNode = SCNNode(geometry: plane)
//        
//        rootNode.addChildNode(planeNode)
        
        let sphere = SCNSphere(radius: 0.4)
        sphere.firstMaterial?.diffuse.contents = UIColor.redColor()
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3(x: 0.0, y: 1.8, z: 0.0)
        rootNode.addChildNode(sphereNode)
        
        let leftLeg = SCNBox(width: 0.2, height: 1.0, length: 0.2, chamferRadius: 0)
        leftLeg.firstMaterial?.diffuse.contents = UIColor.blueColor()
        let leftLegNode = SCNNode(geometry: leftLeg)
        leftLegNode.position = SCNVector3(x: -0.3, y: 0.1, z: 0.0)
        
        let rightLeg = SCNBox(width: 0.2, height: 1.0, length: 0.2, chamferRadius: 0)
        rightLeg.firstMaterial?.diffuse.contents = UIColor.redColor()
        let rightLegNode = SCNNode(geometry: rightLeg)
        rightLegNode.position = SCNVector3(x: 0.3, y: 0.1, z: 0)
        
        let torso = SCNBox(width: 1.0, height: 1.0, length: 0.5, chamferRadius: 0)
        torso.firstMaterial?.diffuse.contents = UIColor.redColor()
        let torsoNode = SCNNode(geometry: torso)
        torsoNode.position = SCNVector3(x: 0.0, y: 1.0, z: 0.0)
        
        let leftArm = SCNBox(width: 0.2, height: 1.0, length: 0.2, chamferRadius: 0)
        leftArm.firstMaterial?.diffuse.contents = UIColor.blueColor()
        let leftArmNode = SCNNode(geometry: leftArm)
        leftArmNode.position = SCNVector3(x: -0.7, y: 1.0, z: 0.0)
        
        let rightArm = SCNBox(width: 0.2, height: 1.0, length: 0.2, chamferRadius: 0)
        rightArm.firstMaterial?.diffuse.contents = UIColor.redColor()
        let rightArmNode = SCNNode(geometry: rightArm)
        rightArmNode.position = SCNVector3(x: 0.7, y: 1.0, z: 0)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.eulerAngles = SCNVector3(x: -0.5, y: 0.0, z: 0.0)
        
        rootNode.addChildNode(cameraNode)

        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 1.8, z: 3)
        
        rootNode.addChildNode(cameraNode)
        rootNode.addChildNode(leftLegNode)
        rootNode.addChildNode(rightLegNode)
        rootNode.addChildNode(torsoNode)
        rootNode.addChildNode(leftArmNode)
        rootNode.addChildNode(rightArmNode)
        
    }
    
    func initializeRobot(/*Pass a scene as a parameter to attach robot nodes to*/) {
        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
}