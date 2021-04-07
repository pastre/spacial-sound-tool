import UIKit
import ARKit
import SceneKit
import AVFoundation

public class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    
    private let sounds: [(String, SCNVector3)] = [
        ("som.wav", .init(x: 0, y: 0, z: -1)),
    ]
    
    let session = ARSession()
    
    let sceneView = ARSCNView()
    
    public override func loadView() {
        print("<View> Load View")
        self.view = sceneView
    }
    
    public override func viewDidLoad() {
        print("<View> Did Load View")
        super.viewDidLoad()
        
        print("<View> Scene View Config")
        sceneView.delegate = self;
        sceneView.session = session;
        sceneView.session.delegate = self;
        sceneView.autoenablesDefaultLighting = true;
        
        
        print("<View> Scene Tracking Config")
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal;
        
        print("<View> Scene Run")
        sceneView.session.run(config)
        print("<View> Scene Run Complete")
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        print("<View> Did Appear View")
        super.viewDidAppear(animated)
        sounds.forEach {
            createSphere(name: $0.0, postion: $0.1)
        }
    }
    
    func createSphere(name: String, postion: SCNVector3) {
        print("<View> Create Sphere")
        let sphere = SCNSphere(radius: 0.1)
        let node = SCNNode(geometry: sphere)
        sceneView.scene.rootNode.addChildNode(node)
        node.position = postion
        let audioSource = SCNAudioSource(fileNamed: name)!
        audioSource.loops = true
        audioSource.load()
        
        node.addAudioPlayer(SCNAudioPlayer(source: audioSource))
    }
}

