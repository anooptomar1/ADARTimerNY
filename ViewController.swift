//
//  ViewController.swift
//  ADARTimerNY
//
//  Created by Анна on 28.12.17.
//  Copyright © 2017 AD. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var sceneDate = SCNText()
    
    @IBOutlet var label: UILabel!
//    @IBOutlet var sceneView: ARSCNView!
    var timerLabel = UILabel()
    
    var seconds: Int = 338548
    //    432000
    var timer = Timer()
    var isTimerRunning = false
//    var sceneDate : SCNText
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
//        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneDate = SCNText(string: "0:0:0:0", extrusionDepth: 1)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.orange
        sceneDate.materials = [material]
        
        let node = SCNNode()
        node.position = SCNVector3(x: 0, y: 0.02, z: -0.1)
        node.scale = SCNVector3(x: 0.01, y: 0.01, z: 0.01)
        node.geometry = sceneDate
        
        sceneView.scene.rootNode.addChildNode(node)
        sceneView.autoenablesDefaultLighting = true
        // Set the scene to the view
        
        //        sceneView.scene = scene
        
        getNYDate()
        runTimer()
//        sceneView.scene = scene
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
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
//    sceneDate = SCNText(string: "", extrusionDepth: 1)
//    let material = SCNMaterial()
//    material.diffuse.contents = UIColor.orange
//    sceneDate.materials = [material]
//
//    let node = SCNNode()
//    node.position = SCNVector3(x: 0.1, y: 0.1, z: -0.1)
//    node.scale = SCNVector3(x: 1, y: 1, z: 1)
//
//    sceneView.scene.rootNode.addChildNode(node)
//    sceneView.autoenablesDefaultLighting = true
//    // Set the scene to the view
//
//    //        sceneView.scene = scene
//
//    getNYDate()
//    runTimer()
//}



    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
            sceneDate.string = timeString(time: TimeInterval(seconds))
        }
    }

    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:(#selector(ViewController.updateTimer)), userInfo:nil, repeats:true)
    }





    func timeString(time:TimeInterval) -> String {
        let days = Int(time) / 86400
        let hours = Int(time) / 3600 % 24
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i:%02i", days, hours, minutes, seconds)
    }

    func getNYDate() {
        let date = Date()
        let year = Calendar.current.component(.year, from: date)
        
        var dateComponents = DateComponents()
        dateComponents.year = year + 1
        dateComponents.month = 1
        dateComponents.day = 1
        dateComponents.hour = 0
        dateComponents.minute = 0
        
        var calendar = Calendar.current
        //        calendar.timeZone = TimeZone(abbreviation: Gregotian)
        calendar.date(from: dateComponents)
    }


}
