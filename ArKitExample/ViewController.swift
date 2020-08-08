//
//  ViewController.swift
//  ArKitExample
//
//  Created by Ezequiel Parada Beltran on 08/08/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first
        
        // Incorporate our touchPOint to AR world
        
        let allARWorldObjects = sceneView.hitTest(touchPoint!.location(in: sceneView), types: [ARHitTestResult.ResultType.featurePoint])
        
        // Recuperate the las object of AR world
        let lastObject = allARWorldObjects.last
        let lastObjectTransform = lastObject!.worldTransform
        
        print("Transform 4x4: \(lastObjectTransform)")
        
        let point3D = SCNVector3(
            lastObjectTransform[3][0],
            lastObjectTransform[3][1],
            lastObjectTransform[3][2]
        )
        print(point3D)
        
        addSphere(point3D: point3D)
        
        
    }
    
    func addSphere(point3D: SCNVector3) {
        let sphere = SCNSphere(radius: 0.01)
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = point3D
        
        self.sceneView.scene.rootNode.addChildNode(sphereNode)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
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
}
