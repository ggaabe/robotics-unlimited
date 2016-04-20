//
//  GameViewController.swift
//  Robotics Unlimited
//
//  Created by Gabe Garrett on 4/12/16.
//  Copyright (c) 2016 Gabe. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import CoreBluetooth

class GameViewController: UIViewController {
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    let backgroundArray = ["art.scnassets/ship.scn", "art.scnassets/spheres.scn", "art.scnassets/squares.scn"]
    var backgroundIndex : Int = 0
    var bleManager : BLEManager!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            print(screenSize)
            let scnView = self.view as! SCNView
            bleManager = BLEManager()
            scnView.scene = SCNScene(named: backgroundArray[backgroundIndex])! //MyScene()
            MyScene().initializeRobot((scnView.scene?.rootNode)!)
            
            scnView.pointOfView = scnView.scene?.rootNode.childNodeWithName("CAMERA", recursively: false)
            print(scnView.scene?.rootNode.childNodes)

        scnView.autoenablesDefaultLighting = true
        
//        let alert = UIAlertView()
//        alert.title = "Alert"
//        alert.message = "Here's a message"
//        alert.addButtonWithTitle("Understod")
//        alert.show()

        
        print("test")
        let armMovementRecognizer = UIPanGestureRecognizer(target: self, action: #selector(GameViewController.handleArmMovement(_:)))
        scnView.addGestureRecognizer(armMovementRecognizer)
        
    }
    
    var previousY :CGFloat = 0
    var initialY :CGFloat = 0
    func handleArmMovement(gestureRecognize: UIGestureRecognizer){
         //retrieve the SCNView
        let scnView = self.view as! SCNView
        
        let p = gestureRecognize.locationInView(scnView)
        let hitResults = scnView.hitTest(p, options: nil)
        
        print("Position: " + String(p.y))
        
        let velocity = (p.y - previousY)
        
        print(velocity)
        
        previousY = p.y
        
        print(hitResults.count)
        if(gestureRecognize.state == UIGestureRecognizerState.Began){
            initialY = p.y
        }
        else if(gestureRecognize.state == UIGestureRecognizerState.Ended){
            if((p.y / screenSize.height) > 0.84 && (initialY / screenSize.height) > 0.84){
                if(backgroundIndex+1 == backgroundArray.count){
                    backgroundIndex = 0
                }else{
                    backgroundIndex += 1
                }
                let newScene = SCNScene(named: backgroundArray[backgroundIndex])!
                MyScene().transferToNewScene((scnView.scene?.rootNode)!, newSceneRootNode: newScene.rootNode)
                scnView.scene = newScene
            }
        }
        if(hitResults.count > 0){
            let result: SCNHitTestResult! = hitResults[0]
            
//            let material = result.node.geometry!.firstMaterial!
            print(String((p.y / screenSize.height)))
            print(result.node.name)
            if(result.node.name == "LEFTARM" || result.node.name == "RIGHTARM"){
                let rotateAction = SCNAction.rotateByAngle(velocity/100, aroundAxis: SCNVector3(x: 2.0, y: 0.0, z: 0.0), duration: 0.0)
                //I CAN POSSIBLY CHANGE THE PIVOT
                result.node.runAction(rotateAction)
                print(result.node.name! + " Euler Angle: " + String(result.node.eulerAngles))
                let angleInfo = result.node.name! + " Euler angle: " + String(result.node.eulerAngles)
                let data = angleInfo.dataUsingEncoding(NSUTF8StringEncoding)
             
                if (bleManager.bleHandler.subscribed){

                    bleManager.bleHandler.globalBLEPeripheralList[0].updateValue(data!, forCharacteristic: bleManager.bleHandler.holyCharacteristic, onSubscribedCentrals: [bleManager.bleHandler.globalBLECentralList[0]])
                }
                
            }
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let alert = UIAlertController(title: "Instructions", message: "Swipe the arms to control arm movement! Swipe the bottom of the screen to change the background!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func handleTap(gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.locationInView(scnView)      //pass a robot arm to locationInView.
        
        let hitResults = scnView.hitTest(p, options: nil)   //pass robotarm to hittest, rotateOnAxis
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result: AnyObject! = hitResults[0]
            
            // get its material
            let material = result.node!.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.setAnimationDuration(0.5)
            
            // on completion - unhighlight
            SCNTransaction.setCompletionBlock {
                SCNTransaction.begin()
                SCNTransaction.setAnimationDuration(0.5)
                
                material.emission.contents = UIColor.blackColor()
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.redColor()
            
            SCNTransaction.commit()
        }
    }

    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
