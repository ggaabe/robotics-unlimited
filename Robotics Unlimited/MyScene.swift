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
        created = false
        super.init()
    }
    var created : Bool
    func initializeRobot(newSceneRoot: SCNNode) {
        let sphere = SCNSphere(radius: 0.4)
        sphere.firstMaterial?.diffuse.contents = UIColor.greenColor()
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3(x: 0.0, y: 1.8, z: 0.0)
        sphereNode.name = "HEAD"
        
        let leftLeg = SCNBox(width: 0.2, height: 1.0, length: 0.2, chamferRadius: 0)
        leftLeg.firstMaterial?.diffuse.contents = UIColor.blueColor()
        let leftLegNode = SCNNode(geometry: leftLeg)
        leftLegNode.position = SCNVector3(x: -0.3, y: 0.1, z: 0.0)
        leftLegNode.name = "LEFTLEG"
        
        let rightLeg = SCNBox(width: 0.2, height: 1.0, length: 0.2, chamferRadius: 0)
        rightLeg.firstMaterial?.diffuse.contents = UIColor.redColor()
        let rightLegNode = SCNNode(geometry: rightLeg)
        rightLegNode.position = SCNVector3(x: 0.3, y: 0.1, z: 0)
        rightLegNode.name = "RIGHTLEG"
        
        let torso = SCNBox(width: 1.0, height: 1.0, length: 0.5, chamferRadius: 0)
        torso.firstMaterial?.diffuse.contents = UIColor.redColor()
        let torsoNode = SCNNode(geometry: torso)
        torsoNode.position = SCNVector3(x: 0.0, y: 1.0, z: 0.0)
        torsoNode.name = "TORSO"
        
        
        
        //IDEA: Control arms by sliding vertically up and down. They can rotate along a specific axis.
        //Arms will rotate around their center. Therefore they should be made bigger and pushed further away, or a way must be found to rotate them around their base.
        let leftArm = SCNBox(width: 0.2, height: 1.0, length: 0.2, chamferRadius: 0)
        leftArm.firstMaterial?.diffuse.contents = UIColor.greenColor()
        let leftArmNode = SCNNode(geometry: leftArm)
        leftArmNode.position = SCNVector3(x: -0.7, y: 1.0, z: 0.0)
        leftArmNode.pivot = SCNMatrix4MakeTranslation(0.0, -0.0, 0.0)
        leftArmNode.name = "LEFTARM"
        
        let rightArm = SCNBox(width: 0.2, height: 1.0, length: 0.2, chamferRadius: 0)
        rightArm.firstMaterial?.diffuse.contents = UIColor.greenColor()
        let rightArmNode = SCNNode(geometry: rightArm)
        rightArmNode.position = SCNVector3(x: 0.7, y: 1.0, z: 0)
        rightArmNode.name = "RIGHTARM"
        
        let cameraNode = SCNNode()
        cameraNode.name = "CAMERA"
        cameraNode.camera = SCNCamera()
        cameraNode.eulerAngles = SCNVector3(x: -0.5, y: 0.0, z: 0.0)
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 2.6/*2.3*/, z: 2.7)
        
        newSceneRoot.addChildNode(leftLegNode)
        newSceneRoot.addChildNode(rightLegNode)
        newSceneRoot.addChildNode(torsoNode)
        newSceneRoot.addChildNode(leftArmNode)
        newSceneRoot.addChildNode(rightArmNode)
        newSceneRoot.addChildNode(sphereNode)
        
        newSceneRoot.addChildNode(cameraNode)

    }
    
    /*
     We use the following function to maintain robot joint position across background changes.
    */
    func transferToNewScene(oldSceneRoot: SCNNode, newSceneRootNode: SCNNode){
        newSceneRootNode.addChildNode(oldSceneRoot.childNodeWithName("LEFTLEG", recursively: false)!)
        newSceneRootNode.addChildNode(oldSceneRoot.childNodeWithName("RIGHTLEG", recursively: false)!)
        newSceneRootNode.addChildNode(oldSceneRoot.childNodeWithName("TORSO", recursively: false)!)
        newSceneRootNode.addChildNode(oldSceneRoot.childNodeWithName("LEFTARM", recursively: false)!)
        newSceneRootNode.addChildNode(oldSceneRoot.childNodeWithName("RIGHTARM", recursively: false)!)
        newSceneRootNode.addChildNode(oldSceneRoot.childNodeWithName("HEAD", recursively: false)!)
        newSceneRootNode.addChildNode(oldSceneRoot.childNodeWithName("CAMERA", recursively: false)!)

    }
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
}